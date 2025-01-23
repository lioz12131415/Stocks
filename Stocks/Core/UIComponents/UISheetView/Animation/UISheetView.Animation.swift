//
//  UISheetView.Animation.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISheetAnimation {
    func animate(_ animation: @escaping() -> Void, _ completion: (() -> Void)? = nil) {
        
    }
}

extension UISheetAnimation {
    internal static func animate(delay:    CGFloat = .zero,
                                 duration: CGFloat = .zero) -> UISheetAnimation {
        return UISheetBasicAnimation(delay: delay, duration: duration)
    }
}

extension UISheetAnimation {
    internal static func animate(delay:    CGFloat = .zero,
                                 duration: CGFloat = .zero, damping: CGFloat, velocity: CGFloat) -> UISheetAnimation {
        return UISheetSpringAnimation(delay:   delay,
                                      damping: damping, duration: duration, velocity: velocity)
    }
}

