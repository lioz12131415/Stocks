//
//  SecureCollectionObserve.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public class SecureCollectionObserve: SecureObserve, SecurableCollectionObserve {
 
    fileprivate var onDecreaseReceive: Receive = .on(.main)
    fileprivate var onIncreaseReceive: Receive = .on(.main)
    
    fileprivate var onDecreaseBlock: (() -> Void)?
    fileprivate var onIncreaseBlock: (() -> Void)?
    
    public required init(_ observer: NSObject?, _ secureObject: (any SecurableObject)?) {
        super.init(observer, secureObject)
    }
    
    public override func remove() {
        super.remove()
        self.onDecreaseBlock = nil
        self.onIncreaseBlock = nil
    }
    
    internal func decreased() {
        self.onDecreaseReceive.sync { [weak self] in self?.onDecreaseBlock?() }
    }
    
    internal func increased() {
        self.onIncreaseReceive.sync { [weak self] in self?.onIncreaseBlock?() }
    }
  
    public func onDecrease(_ block: @escaping () -> Void) -> Self {
        self.onDecreaseBlock   = block
        self.onDecreaseReceive = .on(.main)
        return self
    }
    
    public func onIncrease(_ block: @escaping () -> Void) -> Self {
        self.onIncreaseBlock   = block
        self.onIncreaseReceive = .on(.main)
        return self
    }
    
    public func onDecrease(receive: Receive, _ block: @escaping () -> Void) -> Self {
        self.onDecreaseBlock   = block
        self.onDecreaseReceive = receive
        return self
    }
    
    public func onIncrease(receive: Receive, _ block: @escaping () -> Void) -> Self {
        self.onIncreaseBlock   = block
        self.onIncreaseReceive = receive
        return self
    }
}
