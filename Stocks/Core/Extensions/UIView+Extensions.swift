//
//  UIView+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UIView {
    internal convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color
    }
}

extension UIView {
    internal func sendToBack(_ view: UIView?) {
        guard let view = view else {
            return
        }
        self.sendSubviewToBack(view)
    }
}

extension UIView {
    internal func bringToFront(_ view: UIView?) {
        guard let view = view else {
            return
        }
        self.bringSubviewToFront(view)
    }
}

extension UIView {
    internal func add(to v:   UIView,
                      top:    CGFloat = .zero,
                      left:   CGFloat = .zero,
                      right:  CGFloat = .zero,
                      bottom: CGFloat = .zero, sendToBack: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(self)
        
        if sendToBack {
            v.sendSubviewToBack(self)
        }
        
        autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight,
        ]
        topAnchor.constraint(equalTo:    v.topAnchor,    constant: top).isActive    = true
        leftAnchor.constraint(equalTo:   v.leftAnchor,   constant: left).isActive   = true
        rightAnchor.constraint(equalTo:  v.rightAnchor,  constant: right).isActive  = true
        bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: bottom).isActive = true
    }
}

extension UIView {
    internal func insert(to v: UIView?, at index: Int) {
        guard let v = v else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        v.insertSubview(self, at: index)
        
        autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight,
        ]

        widthAnchor.constraint(equalTo:   v.widthAnchor,   constant: 0).isActive = true
        heightAnchor.constraint(equalTo:  v.heightAnchor,  constant: 0).isActive = true
        centerXAnchor.constraint(equalTo: v.centerXAnchor, constant: 0).isActive = true
        centerYAnchor.constraint(equalTo: v.centerYAnchor, constant: 0).isActive = true
    }
}
