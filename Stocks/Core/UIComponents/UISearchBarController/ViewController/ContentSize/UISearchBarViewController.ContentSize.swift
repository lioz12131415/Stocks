//
//  UISearchBarViewController.ContentSize.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UISearchBarViewController {
    final class ContentSize {
        
        typealias Target      = UIScrollView
        typealias didSetBlock = (CGSize) -> Void
        typealias Observation = NSKeyValueObservation
        
        fileprivate weak var target: Target? = nil
        fileprivate var didSetBlock: didSetBlock? = nil
        fileprivate var observation: Observation? = nil
        
        fileprivate var contentSize: CGSize = .zero {
            didSet { }
        }
        
        internal func set(_ target: UIScrollView?) {
            self.clear()
            self.target      = target
            self.observation = observe()
        }
        
        internal func didSet(_ block: @escaping(CGSize) -> Void) {
            self.didSetBlock = block
        }
        
        fileprivate func clear() {
            self.observation?.invalidate()
            self.observation = nil
            self.didSetBlock = nil
            self.target      = nil
        }
        
        fileprivate func observe() -> Observation? {
            return target?.observe(\.contentSize, options: [.new, .old]) { [weak self] object, change in
                guard let self     = self,
                      let oldValue = change.oldValue,
                      let newValue = change.newValue, newValue != oldValue else {
                    return
                }
                self.contentSize = newValue
                self.didSetBlock?(.init(width: newValue.width, height: newValue.height))
            }
        }
    }
}
