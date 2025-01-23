//
//  UISheetRect.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class UISheetRect {
    
    typealias Target      = UIView
    typealias DidSetBlock = () -> Void
    typealias Observation = NSKeyValueObservation
    
    fileprivate weak var target: Target? = nil
    fileprivate var didSetBlock: DidSetBlock? = nil
    fileprivate var observation: Observation? = nil
    
    internal var size: CGSize {
        return target?.frame.size ?? .zero
    }
    
    internal var origin: CGPoint {
        return target?.frame.origin ?? .zero
    }
    
    internal var center: CGPoint {
        return target?.center ?? .zero
    }
    
    internal init(_ didSetBlock: @escaping DidSetBlock) {
        self.didSetBlock = didSetBlock
    }
    
    @discardableResult func set(_ target: Target?) -> Self {
        self.clear()
        self.target      = target
        self.observation = observe()
        return self
    }
    
    fileprivate func clear() {
        self.observation?.invalidate()
        self.observation = nil
        self.target      = nil
    }
    
    fileprivate func observe() -> Observation? {
        return target?.observe(\.frame, options: [.new, .old]) { [weak self] object, change in
            guard let newValue = change.newValue,
                  let oldValue = change.oldValue, newValue != oldValue else {
                return
            }
            self?.didSetBlock?()
        }
    }
}
