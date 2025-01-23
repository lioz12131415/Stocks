//
//  UISheetSpringAnimation.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class UISheetSpringAnimation: UISheetAnimation {
    
    private(set) var delay:    CGFloat = .zero
    private(set) var damping:  CGFloat = .zero
    private(set) var duration: CGFloat = .zero
    private(set) var velocity: CGFloat = .zero
    
    internal init(delay: CGFloat, duration: CGFloat) {
        self.delay    = delay
        self.duration = duration
    }
    
    internal init(delay: CGFloat, damping: CGFloat, duration: CGFloat, velocity: CGFloat) {
        self.delay    = delay
        self.damping  = damping
        self.duration = duration
        self.velocity = velocity
    }
    
    override func animate(_ animation: @escaping() -> Void, _ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: [], animations: { animation() }, completion: { _ in completion?() })
    }
}
