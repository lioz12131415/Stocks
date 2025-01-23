//
//  UISheetBasicAnimation.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class UISheetBasicAnimation: UISheetAnimation {
    
    private(set) var delay:    CGFloat = .zero
    private(set) var duration: CGFloat = .zero
    
    internal init(delay: CGFloat, duration: CGFloat) {
        self.delay    = delay
        self.duration = duration
    }
    
    override func animate(_ animation: @escaping() -> Void, _ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay) { animation() } completion: { _ in
            completion?()
        }
    }
}
