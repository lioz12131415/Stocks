//
//  DualAnimationQueue.Animation.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension DualAnimationQueue {
    class Animation: NSObject {
        
        private(set) weak var view: UIView?
        
        private(set) var delay:      CGFloat = 0.0
        private(set) var damping:    CGFloat = 1.0
        private(set) var velocity:   CGFloat = 0.0
        private(set) var duration:   CGFloat = 0.0
        
        fileprivate var doneBlock:      (() -> Void)? = nil
        fileprivate var completion:     (() -> Void)? = nil
        fileprivate var didStopBlock:   (() -> Void)? = nil
        fileprivate var didStartBlock:  (() -> Void)? = nil
        fileprivate var willStartBlock: (() -> Void)? = nil
        
        internal init(view:       UIView? = nil,
                      delay:      CGFloat = 0.0,
                      damping:    CGFloat = 1.0,
                      velocity:   CGFloat = 0.0,
                      duration:   CGFloat = 0.0,
                      completion: (() -> Void)? = nil) {
            self.view       = view
            self.delay      = delay
            self.damping    = damping
            self.velocity   = velocity
            self.duration   = duration
            self.completion = completion
        }
        
        internal func done() {
            self.didStopBlock?()
            self.completion?()
            self.doneBlock?()
        }
        
        internal func prepare() {
            self.willStartBlock?()
        }
        
        internal func animate() {
            self.didStartBlock?()
        }

        final func fire(_ block: @escaping() -> Void) {
            self.doneBlock = block
            self.prepare()
            self.animate()
        }
        
        @discardableResult
        func didStop(_ block: @escaping() -> Void) -> Self {
            self.didStopBlock = block
            return self
        }
        
        @discardableResult
        func didStart(_ block: @escaping() -> Void) -> Self {
            self.didStartBlock = block
            return self
        }
        
        @discardableResult
        func willStart(_ block: @escaping() -> Void) -> Self {
            self.willStartBlock = block
            return self
        }
    }
}
