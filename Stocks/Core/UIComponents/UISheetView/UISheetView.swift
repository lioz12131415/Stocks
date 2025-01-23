//
//  UISheetView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISheetView: UIView {
    
    typealias Observe  = UISheetViewSceneObserve
    typealias Observer = UISheetViewSceneObserver
    
    typealias Detent    = UISheetDetent
    typealias Detents   = UISheetDetents
    typealias Animation = UISheetAnimation
    
    private(set) lazy var detents: Detents = {
        return Detents([.large(), .medium(), .small()])
    }()
    
    private(set) lazy var visability: Visability = {
        return .hidden
    }()
    
    private(set) lazy var rect: UISheetRect = {
        return UISheetRect { [weak self] in self?.update() }
    }()
    
    private(set) lazy var progress: UISheetProgress = {
        return UISheetProgress { [weak self] in self?.didProgressChanged() }
    }()
    
    private(set) lazy var gesture: UISheetPanGesture = {
        return UISheetPanGesture { [weak self] in self?.pan() }
    }()
    
    private(set) lazy var edgeInsets: UISheetEdgeInsets = {
        return UISheetEdgeInsets { [weak self] in self?.update() }
    }()
    
    private(set) lazy var ignoreSafeArea: UISheetIgnoreSafeArea = {
        return UISheetIgnoreSafeArea { [weak self] in self?.update() }
    }()
    
    fileprivate lazy var scene: UISheetViewScene = {
        return UISheetViewScene()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.update()
    }
    
    internal func observe(_ target: NSObject) -> Observe {
        return scene.observe(target)
    }
    
    internal func bind(to view: UIView, detents: Set<UISheetDetent>) {
        view.addSubview(self)
        
        self.detents = UISheetDetents(Array(detents))
        self.gesture.bind(to: self)
        self.progress.set(self)
        self.rect.set(view)
        self.update()
    }
    
    fileprivate func pan() {
        let velocity    = gesture.velocity(in: self)
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
            case .ended:   ended  (translation: translation, velocity: velocity)
            case .began:   changed(translation: translation, velocity: velocity)
            case .changed: changed(translation: translation, velocity: velocity)
        default:
            ended(translation: translation, velocity: velocity)
        }
    }
    
    fileprivate func didProgressChanged() {
        scene.didChange(progress.current)
    }
    
    fileprivate func ended(translation: CGPoint, velocity: CGPoint) {
        guard let current = detents.current,
              let detent  = detents.nearest(to: frame.minY, velocity: velocity.y) else {
            return
        }
        scene.willSet(detent, current)
        detents.update(current: detent)
        Animation.animate(duration: 0.2).animate ({ [weak self] in self?.update() }, { [weak self]in
            self?.scene.didSet(detent, current)
        })
        gesture.setTranslation(.zero, in: self)
        superview?.layoutIfNeeded()
    }
    
    
    fileprivate func changed(translation: CGPoint, velocity: CGPoint) {
        frame.origin.y = max(detents.largest.y, frame.minY + translation.y)
        gesture.setTranslation(.zero, in: self)
        superview?.layoutIfNeeded()
    }
    
    fileprivate func update() {
        guard let current   = detents.current,
              let superview = superview else {
            return
        }
        
        let et = edgeInsets.top
        let el = edgeInsets.left
        let er = edgeInsets.right
        let eb = edgeInsets.bottom
        
        let st = ignoreSafeArea.top(superview)
        let sl = ignoreSafeArea.left(superview)
        let sr = ignoreSafeArea.right(superview)
        let sb = ignoreSafeArea.bottom(superview)
        
        let x = (rect.origin.x+(sl+el))
        let w = (rect.size.width-(el+er+sl+sr))
        let h = (rect.size.height-(et+eb+st+sb))
        let y = (rect.origin.y-(eb+sb))+(rect.size.height)
        
        detents
            .set(large:  y-h)
            .set(small:  y+(eb+sb))
            .set(medium: y-h/2)
                
        detents.sort(by: { $0.y > $1.y })
        
        self.frame = if visability == .hidden {
            CGRect(x: x, y: y, width: w, height: h)
        } else {
            CGRect(x: x, y: current.y, width: w, height: h)
        }
    }
}

extension UISheetView {
    internal func hide(animation: Animation = .animate()) {
        guard visability == .shown else {
            return
        }
        visability.toggle()
        scene.willSet(.hidden, .shown)
        animation.animate ({ [weak self] in self?.update() }, { [weak self] in
            self?.scene.didSet(.hidden, .shown)
        })
    }
    
    internal func show(animation: Animation = .animate()) {
        guard visability == .hidden else {
            return
        }
        visability.toggle()
        scene.willSet(.shown, .hidden)
        animation.animate ({ [weak self] in self?.update() }, { [weak self] in
            self?.scene.didSet(.shown, .hidden)
        })
    }
    
    internal func show(animation: Animation = .animate(), detent: Detent.`Type`) {
        guard let detent  = detents.get(detent),
              let current = detents.current, current != detent, visability == .hidden else {
            return show(animation: animation)
        }
        visability.toggle()
        scene.willSet(detent, current)
        scene.willSet(.shown, .hidden)
        detents.update(current: detent)
        animation.animate ({ [weak self] in self?.update() }, { [weak self] in
            self?.scene.didSet(detent, current)
            self?.scene.didSet(.shown, .hidden)
        })
    }
    
    internal func move(to detent: Detent.`Type`, with animation: Animation = .animate()) {
        guard let detent  = detents.get(detent),
              let current = detents.current, visability == .shown else {
            return
        }
        scene.willSet(detent, current)
        detents.update(current: detent)
        animation.animate ({ [weak self] in self?.update() }, { [weak self] in
            self?.scene.didSet(detent, current)
        })
    }
}


