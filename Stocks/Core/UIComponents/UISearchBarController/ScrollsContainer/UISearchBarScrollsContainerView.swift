//
//  UISearchBarScrollsContainerView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarScrollsContainerView: UIView {
    
    typealias Scene               = SearchBarScrollsContainerScene
    typealias Scenes              = UISearchBarControllerScenes
    typealias OverlayScrollView   = UISearchBarOverlayScrollView
    typealias ContainerScrollView = UISearchBarContainerScrollView
    
    private(set) weak var scenes:              Scenes?             = nil
    private(set) lazy var overlayScrollView:   OverlayScrollView   = OverlayScrollView()
    private(set) lazy var containerScrollView: ContainerScrollView = ContainerScrollView()
    
    fileprivate lazy var scene: Scene = {
        return Scene()
    }()
    
    fileprivate var index: Int {
        return scenes?.pageViewController?.metadata.index ?? .zero
    }
    
    fileprivate var contentSize: CGSize {
        let s = scenes?.pageViewController?.metadata.contentSize  ?? .zero
        let i = scenes?.pageViewController?.metadata.contentInset ?? .zero
        let h = s.height <= 0 ? s.height :  max(frame.height+1, s.height + i.bottom)
        return .init(width: s.width, height: h)
    }
    
    fileprivate var scrollView: UIScrollView? {
        return scenes?.pageViewController?.metadata.scrollView
    }
    
    fileprivate var scrollViews: [UIScrollView?]? {
        return scenes?.pageViewController?.metadata.scrollViews
    }
    
    fileprivate var searchBarHeight: CGFloat = 52.0 {
        didSet { }
    }
    
    internal var contentView: UISearchBarContainerScrollContentView {
        return containerScrollView.contentView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .clear
        self.commit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.backgroundColor = .clear
        self.commit()
    }
    
    fileprivate func commit() {
        self.overlayScrollView.delegate = self
        
        self.overlayScrollView.add(to: self)
        self.containerScrollView.add(to: self)
        self.containerScrollView.addGestureRecognizer(overlayScrollView.panGestureRecognizer)
        self.containerScrollView.contentSize(with: frame, size: frame.size, searchBarHeight: searchBarHeight)
    }
    
    internal func set(scenes: Scenes) {
        self.scenes = scenes
        self.scenes?.set(scene: scene)
        
        self.scenes?.fieldContainer?
            .observe(self).endEditing { [weak self] in self?.update(52.0) }
        self.scenes?.fieldContainer?
            .observe(self).beginEditing { [weak self] in self?.update(00.0) }
        
        self.scenes?.pageViewController?.observe(self)
            .didChange(bounds: { [weak self] newValue in self?.update(newValue) })
        self.scenes?.pageViewController?.observe(self)
            .didChange(contentSize: { [weak self] newValue in self?.update(newValue) })
        self.scenes?.pageViewController?.observe(self)
            .didChange(viewController: { [weak self] newValue in self?.update(newValue) })
    }
    
    internal func set(adjustmentBehavior: Bool) {
        self.overlayScrollView.adjustmentBehavior(adjustmentBehavior)
        self.scrollViews?.forEach { $0?.contentInsetAdjustmentBehavior = adjustmentBehavior ? .always : .never }
    }
    
    internal func set(isScrollEnable: Bool) {
        self.overlayScrollView.isScrollEnabled(isScrollEnable)
        self.containerScrollView.isScrollEnabled(isScrollEnable)
    }
    
    fileprivate func update(_ rect: CGRect) {
        guard overlayScrollView.contentOffset.y > searchBarHeight,
              overlayScrollView.contentOffset.y-searchBarHeight != rect.origin.y else {
            return
        }
        overlayScrollView.contentOffset.y = rect.origin.y+searchBarHeight
    }
    
    fileprivate func update(_ height: CGFloat) {
        searchBarHeight = height
        scrollViewDidScroll(overlayScrollView)
    }
    
    fileprivate func update(_ size: CGSize) {
        overlayScrollView.scrollView(scrollView)
        set(adjustmentBehavior: overlayScrollView.contentInsetAdjustmentBehavior == .always)
        overlayScrollView.contentSize(with: frame, size: contentSize, searchBarHeight: searchBarHeight)
    }
    
    fileprivate func update(_ viewController: UISearchBarViewController?) {
        overlayScrollView.scrollView(scrollView)
        overlayScrollView.change(index: index, or: containerScrollView.contentOffset.y)
        set(adjustmentBehavior: overlayScrollView.contentInsetAdjustmentBehavior == .always)
        overlayScrollView.contentSize(with: frame, size: contentSize, searchBarHeight: searchBarHeight)
    }
}

extension UISearchBarScrollsContainerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = overlayScrollView.contentOffset.y
        
        if let index = scenes?.pageViewController?.metadata.index {
            if let offset = overlayScrollView.contentOffsets[index], 
                offset != y, (scrollView.isTracking || scrollView.isDragging) {
                scene.didScroll(scrollView)
            }
            overlayScrollView.contentOffsets[index] = y
        }
        
        if scrollView.contentOffset.y < searchBarHeight {
            overlayScrollView.contentOffsets.removeAll()
            containerScrollView.contentOffset.y = max(0, y)
            scrollViews?.forEach { $0?.contentOffset.y = y < 0 ? y : 0 }
        }
        else {
            containerScrollView.contentOffset.y = searchBarHeight
            scenes?.pageViewController?.metadata.scrollView?.contentOffset.y = y-searchBarHeight
        }
    }
}
