//
//  UISearchBarViewController.ContentInset.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UISearchBarViewController {
    final class ContentInset {
        
        typealias Target      = UIScrollView
        typealias Observation = NSKeyValueObservation
        typealias didSetBlock = (UIEdgeInsets) -> Void
        
        fileprivate weak var target: Target? = nil
        fileprivate var didSetBlock: didSetBlock? = nil
        fileprivate var observation: Observation? = nil
        
        fileprivate var contentInset: UIEdgeInsets {
            return .init(top:    self.target?.contentInset.top    ?? .zero,
                         left:   self.target?.contentInset.left   ?? .zero,
                         bottom: self.target?.contentInset.bottom ?? .zero,
                         right:  self.target?.contentInset.right  ?? .zero)
        }
        
        internal func set(_ target: UIScrollView?) {
            self.clear()
            self.target               = target
            self.observation          = observe()
            self.target?.contentInset = contentInset
        }
        
        internal func didSet(_ block: @escaping(UIEdgeInsets) -> Void) {
            self.didSetBlock = block
        }
        
        fileprivate func clear() {
            self.observation?.invalidate()
            self.observation = nil
            self.didSetBlock = nil
            self.target      = nil
        }
        
        fileprivate func observe() -> Observation? {
            return target?.observe(\.contentInset, options: [.new, .old]) { [weak self] object, change in
                guard let self     = self,
                      let oldValue = change.oldValue,
                      let newValue = change.newValue, (newValue != oldValue || newValue.bottom == 0) else {
                    return
                }
                let inset = UIEdgeInsets(top:    newValue.top,
                                         left:   newValue.left,
                                         bottom: max(52, newValue.bottom), right: newValue.right)
                self.target?.contentInset = inset
                self.didSetBlock?(inset)
            }
        }
    }
}


