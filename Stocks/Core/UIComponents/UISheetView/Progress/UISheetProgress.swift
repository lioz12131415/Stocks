//
//  UISheetProgress.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final class UISheetProgress {
    
    typealias Target      = UISheetView
    typealias DidSetBlock = () -> Void
    typealias Observation = NSKeyValueObservation
    
    fileprivate weak var target: Target? = nil
    fileprivate var didSetBlock: DidSetBlock? = nil
    fileprivate var observation: Observation? = nil
    
    private(set) var current: CGFloat = .zero
    
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
            guard let l = self?.target?.detents.large,
                  let s = self?.target?.detents.small,
                  let m = self?.target?.detents.medium else {
                return
            }
            let progress = if newValue.minY >= m.y {
                0.5 * (s.y - newValue.minY) / (s.y - m.y)
            } else {
                0.5 + 0.5 * (m.y - newValue.minY) / (m.y - l.y)
            }
            guard (self?.current ?? .zero) != progress else {
                return
            }
            self?.current = progress
            self?.didSetBlock?()
        }
    }
}
