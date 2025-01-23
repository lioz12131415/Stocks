//
//  Ordered+Observe.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Ordered {
    public class Observe: NSObject, OrderedObserve {
        
        fileprivate var onSaveReceive:   Receive = .on(.main)
        fileprivate var onChangeReceive: Receive = .on(.main)
        fileprivate var onRemoveReceive: Receive = .on(.main)
        fileprivate var onUpdateReceive: Receive = .on(.main)
        
        fileprivate var onSaveBlock:   (() -> Void)?
        fileprivate var onChangeBlock: (() -> Void)?
        fileprivate var onRemoveBlock: (() -> Void)?
        fileprivate var onUpdateBlock: (() -> Void)?
        
        fileprivate weak var ordered:  Ordered? = nil
        fileprivate weak var observer: NSObject? = nil
        
        internal init(_ ordered: Ordered?, _ observer: NSObject?) {
            super.init()
            self.ordered  = ordered
            self.observer = observer
        }
        
        internal func remove() {
            self.onSaveBlock   = nil
            self.onChangeBlock = nil
            self.onRemoveBlock = nil
            self.onUpdateBlock = nil
            self.ordered?.remove(observer: observer)
        }
        
        internal func saved() {
            self.onSaveReceive.sync { [weak self] in self?.onSaveBlock?() }
        }
        
        internal func changed() {
            self.onChangeReceive.sync { [weak self] in self?.onChangeBlock?() }
        }
        
        internal func removed() {
            self.onRemoveReceive.sync { [weak self] in self?.onRemoveBlock?() }
        }
        
        internal func updated() {
            self.onUpdateReceive.sync { [weak self] in self?.onUpdateBlock?() }
        }
        
        public func onSave(_ block: @escaping() -> Void) -> Self {
            self.onSaveBlock   = block
            self.onSaveReceive = .on(.main)
            return self
        }
        
        public func onChange(_ block: @escaping() -> Void) -> Self {
            self.onChangeBlock   = block
            self.onChangeReceive = .on(.main)
            return self
        }
        
        public func onRemove(_ block: @escaping() -> Void) -> Self {
            self.onRemoveBlock   = block
            self.onRemoveReceive = .on(.main)
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
        
        public func onChange(receive: Receive, _ block: @escaping() -> Void) -> Self {
            self.onChangeBlock   = block
            self.onChangeReceive = receive
            return self
        }
        
        public func onRemove(receive: Receive, _ block: @escaping() -> Void) -> Self {
            self.onRemoveBlock   = block
            self.onRemoveReceive = receive
            return self
        }
        
        public func onUpdate(receive: Receive, _ block: @escaping() -> Void) -> Self {
            self.onUpdateBlock   = block
            self.onUpdateReceive = receive
            return self
        }
    }
}

public protocol OrderedObserve {
    
    typealias Receive = Work.Receive
    
    @discardableResult func onSave  (_ block: @escaping() -> Void) -> Self
    @discardableResult func onChange(_ block: @escaping() -> Void) -> Self
    @discardableResult func onRemove(_ block: @escaping() -> Void) -> Self
    @discardableResult func onUpdate(_ block: @escaping() -> Void) -> Self
    
    @discardableResult func onSave  (receive: Receive, _ block: @escaping() -> Void) -> Self
    @discardableResult func onChange(receive: Receive, _ block: @escaping() -> Void) -> Self
    @discardableResult func onRemove(receive: Receive, _ block: @escaping() -> Void) -> Self
    @discardableResult func onUpdate(receive: Receive, _ block: @escaping() -> Void) -> Self
}

