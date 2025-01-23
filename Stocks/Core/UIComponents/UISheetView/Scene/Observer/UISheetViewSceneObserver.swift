//
//  UISheetViewSceneObserver.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final class UISheetViewSceneObserver: NSObject, UISheetViewSceneObserve {
    
    typealias Detent     = UISheetDetent
    typealias Visability = UISheetView.Visability
    
    fileprivate var didChangeProgress: ((CGFloat) -> Void)?
    
    fileprivate var didSetDetentNew:     ((Detent) -> Void)?
    fileprivate var willSetDetentNew:    ((Detent) -> Void)?
    fileprivate var didSetDetentNewOld:  ((Detent, Detent) -> Void)?
    fileprivate var willSetDetentNewOld: ((Detent, Detent) -> Void)?
    
    fileprivate var didSetVisabilityNew:     ((Visability) -> Void)?
    fileprivate var willSetVisabilityNew:    ((Visability) -> Void)?
    fileprivate var didSetVisabilityNewOld:  ((Visability, Visability) -> Void)?
    fileprivate var willSetVisabilityNewOld: ((Visability, Visability) -> Void)?
    
    internal func didChange(_ progress: CGFloat) {
        self.didChangeProgress?(progress)
    }
    
    internal func willSet(_ newValue: Detent, _ oldValue: Detent) {
        self.willSetDetentNew?(newValue)
        self.willSetDetentNewOld?(newValue, oldValue)
    }
    
    internal func didSet(_ newValue: Detent, _ oldValue: Detent) {
        self.didSetDetentNew?(newValue)
        self.didSetDetentNewOld?(newValue, oldValue)
    }
    
    internal func didSet(_ newValue: Visability, _ oldValue: Visability) {
        self.didSetVisabilityNew?(newValue)
        self.didSetVisabilityNewOld?(newValue, oldValue)
    }
    
    internal func willSet(_ newValue: Visability, _ oldValue: Visability) {
        self.willSetVisabilityNew?(newValue)
        self.willSetVisabilityNewOld?(newValue, oldValue)
    }
    
    @discardableResult
    func didChange(_ block: @escaping (_ progress: CGFloat) -> Void) -> Self {
        self.didChangeProgress = block
        return self
    }
    
    @discardableResult
    func didSetDetent(_ block: @escaping(_ newValue: Detent) -> Void) -> Self {
        self.didSetDetentNew = block
        return self
    }
    
    @discardableResult
    func willSetDetent(_ block: @escaping(_ newValue: Detent) -> Void) -> Self {
        self.willSetDetentNew = block
        return self
    }
    
    @discardableResult
    func didSetVisability(_ block: @escaping(_ newValue: Visability) -> Void) -> Self {
        self.didSetVisabilityNew = block
        return self
    }
    
    @discardableResult
    func willSetVisability(_ block: @escaping(_ newValue: Visability) -> Void) -> Self {
        self.willSetVisabilityNew = block
        return self
    }
    
    @discardableResult
    func didSetDetent(_ block: @escaping(_ newValue: Detent, 
                                         _ oldValue: Detent) -> Void) -> Self {
        self.didSetDetentNewOld = block
        return self
    }
    
    @discardableResult
    func willSetDetent(_ block: @escaping(_ newValue: Detent, 
                                          _ oldValue: Detent) -> Void) -> Self {
        self.willSetDetentNewOld = block
        return self
    }
    
    @discardableResult
    func didSetVisability(_ block: @escaping(_ newValue: Visability, 
                                             _ oldValue: Visability) -> Void) -> Self {
        self.didSetVisabilityNewOld = block
        return self
    }
    
    @discardableResult
    func willSetVisability(_ block: @escaping(_ newValue: Visability,
                                              _ oldValue: Visability) -> Void) -> Self {
        self.willSetVisabilityNewOld = block
        return self
    }
}


