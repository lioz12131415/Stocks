//
//  UISheetPanGesture.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class UISheetPanGesture: NSObject {
    
    typealias DidSetBlock = () -> Void
    
    fileprivate lazy var gesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
    }()
    
    fileprivate var didSetBlock: DidSetBlock? = nil {
        didSet { }
    }
    
    internal var view: UIView? {
        return gesture.view
    }
    
    internal var state: UIGestureRecognizer.State {
        return gesture.state
    }
    
    internal init(_ didSetBlock: @escaping DidSetBlock) {
        super.init()
        self.didSetBlock = didSetBlock
        self.gesture.delaysTouchesEnded = true
        self.gesture.delaysTouchesBegan = false
    }
    
    internal func bind(to view: UIView) {
        view.addGestureRecognizer(gesture)
    }
    
    internal func velocity(in view: UIView?) -> CGPoint {
        self.gesture.velocity(in: view)
    }
    
    internal func translation(in view: UIView?) -> CGPoint {
        self.gesture.translation(in: view)
    }
    
    internal func setTranslation(_ translation: CGPoint, in view: UIView?) {
        self.gesture.setTranslation(translation, in: view)
    }
        
    @objc
    fileprivate func pan(_ recognizer: UIPanGestureRecognizer) {
        self.didSetBlock?()
    }
}
