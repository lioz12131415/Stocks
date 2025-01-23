//
//  UISheetEdgeInsets.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final class UISheetEdgeInsets {
    
    typealias DidSetBlock = () -> Void
    
    private(set) var top:    CGFloat = .zero
    private(set) var left:   CGFloat = .zero
    private(set) var right:  CGFloat = .zero
    private(set) var bottom: CGFloat = .zero
    
    fileprivate var didSetBlock: DidSetBlock? = nil {
        didSet { }
    }
    
    internal init(didSetBlock: @escaping DidSetBlock) {
        self.didSetBlock = didSetBlock
    }
    
    @discardableResult func top(_ newValue: CGFloat) -> Self {
        self.top = newValue
        self.didSetBlock?()
        return self
    }
    
    @discardableResult func left(_ newValue: CGFloat) -> Self {
        self.left = newValue
        self.didSetBlock?()
        return self
    }
    
    @discardableResult func right(_ newValue: CGFloat) -> Self {
        self.right = newValue
        self.didSetBlock?()
        return self
    }
    
    @discardableResult func bottom(_ newValue: CGFloat) -> Self {
        self.bottom = newValue
        self.didSetBlock?()
        return self
    }
}
