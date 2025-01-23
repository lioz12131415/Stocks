//
//  UISearchBarViewController.Bounds.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UISearchBarViewController {
    final class Bounds {
        
        typealias Target      = UIScrollView
        typealias didSetBlock = (CGRect) -> Void
        typealias Observation = NSKeyValueObservation
        
        fileprivate weak var target: Target? = nil
        fileprivate var didSetBlock: didSetBlock? = nil
        fileprivate var observation: Observation? = nil
        
        internal func set(_ target: UIScrollView?) {
            self.clear()
            self.target      = target
            self.observation = observe()
        }
        
        internal func didSet(_ block: @escaping(CGRect) -> Void) {
            self.didSetBlock = block
        }
        
        fileprivate func clear() {
            self.observation?.invalidate()
            self.observation = nil
            self.didSetBlock = nil
            self.target      = nil
        }
        
        fileprivate func observe() -> Observation? {
            return target?.observe(\.bounds, options: [.new, .old]) { [weak self] object, change in
                guard let newValue = change.newValue,
                      let oldValue = change.oldValue, newValue != oldValue else {
                    return
                }
                self?.didSetBlock?(newValue)
            }
        }
    }
}


