//
//  UISheetSafeArea.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class UISheetIgnoreSafeArea {
    
    typealias DidSetBlock = () -> Void
    
    fileprivate var _top:    Bool = false
    fileprivate var _left:   Bool = false
    fileprivate var _right:  Bool = false
    fileprivate var _bottom: Bool = false
    
    fileprivate var didSetBlock: DidSetBlock? = nil {
        didSet { }
    }
    
    internal init(_ didSetBlock: @escaping DidSetBlock) {
        self.didSetBlock = didSetBlock
    }
    
    internal func top(_ superview: UIView) -> CGFloat {
        _top ? .zero : superview.safeAreaInsets.top
    }
    
    internal func left(_ superview: UIView) -> CGFloat {
        _left ? .zero : superview.safeAreaInsets.left
    }
    
    internal func right(_ superview: UIView) -> CGFloat {
        _right ? .zero : superview.safeAreaInsets.right
    }
    
    internal func bottom(_ superview: UIView) -> CGFloat {
        _bottom ? .zero : superview.safeAreaInsets.bottom
    }
    
    @discardableResult func top(_ newValue: Bool) -> Self {
        self._top = newValue
        self.didSetBlock?()
        return self
    }
    
    @discardableResult func left(_ newValue: Bool) -> Self {
        self._left = newValue
        self.didSetBlock?()
        return self
    }
    
    @discardableResult func right(_ newValue: Bool) -> Self {
        self._right = newValue
        self.didSetBlock?()
        return self
    }
    
    @discardableResult func bottom(_ newValue: Bool) -> Self {
        self._bottom = newValue
        self.didSetBlock?()
        return self
    }
}
