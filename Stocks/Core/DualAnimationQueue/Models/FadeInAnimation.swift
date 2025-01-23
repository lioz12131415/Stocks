//
//  FadeInAnimation.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class FadeInAnimation: DualAnimationQueue.Animation {
    override func animate() {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.view?.alpha = 1.0
        } completion: { [weak self] _ in
            self?.done()
        }
    }
}


