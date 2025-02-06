//
//  SecureObserve.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public class SecureObserve: NSObject, SecurableObserve {
    
    fileprivate var onSaveReceive:   Receive = .on(.main)
    fileprivate var onUpdateReceive: Receive = .on(.main)
    
    fileprivate var onSaveBlock:   (() -> Void)?
    fileprivate var onUpdateBlock: (() -> Void)?
    
    fileprivate weak var observer:     NSObject?        = nil
    fileprivate weak var secureObject: SecurableObject? = nil
    
    public required init(_ observer: NSObject?, _ secureObject: SecurableObject?) {
        self.observer     = observer
        self.secureObject = secureObject
    }
    
    public func remove() {
        self.onSaveBlock   = nil
        self.onUpdateBlock = nil
        self.secureObject?.remove(observer: observer)
    }
    
    internal func saved() {
        self.onSaveReceive.sync { [weak self] in self?.onSaveBlock?() }
    }

    internal func updated() {
        self.onUpdateReceive.sync { [weak self] in self?.onUpdateBlock?() }
    }
    
    public func onSave(_ block: @escaping() -> Void) -> Self {
        self.onSaveBlock   = block
        self.onSaveReceive = .on(.main)
        return self
    }
    
    public func onUpdate(_ block: @escaping() -> Void) -> Self {
        self.onUpdateBlock   = block
        self.onUpdateReceive = .on(.main)
        return self
    }
    
    public func onSave(receive: Receive, _ block: @escaping() -> Void) -> Self {
        self.onSaveBlock   = block
        self.onSaveReceive = receive
        return self
    }
    
    public func onUpdate(receive: Receive, _ block: @escaping() -> Void) -> Self {
        self.onUpdateBlock   = block
        self.onUpdateReceive = receive
        return self
    }
}
    
