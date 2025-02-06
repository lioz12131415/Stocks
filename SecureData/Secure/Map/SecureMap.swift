//
//  SecureMap.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Structures
import Foundation

open class SecureMap<Key: Hashable & Codable, Value: Codable>: NSObject, SecurableObject {
    
    public typealias Iterator = Elements.Iterator
    public typealias Elements = OrderedMap<Key, Value>
    
    internal var key: String
    internal var scc: SecureCollectionChange
    internal var obs: Observers<SecureCollectionObserve>
    
    internal var wrp: Wrapper<Elements> {
        didSet { scc.update(wrp.count, obs) }
    }
    
    public var count: Int {
        return wrp.count
    }
    
    public var last: Value? {
        return wrp.last
    }
    
    public var first: Value? {
        return wrp.first
    }
    
    public var isEmpty: Bool {
        return wrp.isEmpty
    }
    
    public var values: Array<Value> {
        return wrp.values
    }
    
    public var keys: ContiguousArray<Key> {
        return wrp.keys
    }
    
    public override var description: String {
        return wrp.sync { $0.description }
    }
    
    public override var debugDescription: String {
        return wrp.sync { $0.debugDescription }
    }
    
    public subscript(key: Key) -> Value? {
        get { wrp[key] }
        set { wrp[key] = newValue }
    }
    
    public subscript(index: Int) -> Value? {
        get { wrp[index] }
        set { wrp[index] = newValue }
    }

    public init(_ key: String) {
        self.key = key
        self.obs = .init()
        self.wrp = .init(key)
        self.scc = .init(wrp.count)
    }
    
    public func save() {
        self.wrp.save()
        self.obs.saved()
    }
    
    public func removeAll() {
        self.wrp.sync { $0.removeAll() }
    }
    
    public func remove(for key: Key) {
        self.wrp.sync { $0.remove(for: key) }
    }
    
    public func remove(at index: Int) {
        self.wrp.sync { $0.remove(at: index) }
    }
        
    public func push(_ value: Value, for key: Key) {
        self.wrp.sync { $0.push(value, for: key) }
    }
    
    public func append(_ value: Value, for key: Key) {
        self.wrp.sync { $0.append(value, for: key) }
    }
        
    public func update(_ value: Value, for key: Key) {
        self.wrp.sync { $0.update(value, for: key) }
    }
    
    public func insert(_ value: Value, for key: Key, at index: Int) {
        self.wrp.sync { $0.insert(value, for: key, at: index) }
    }
    
    public func contains(_ key: Key) -> Bool {
        return wrp.sync { $0.contains(key) }
    }
    
    public func observe(_ observer: NSObject) -> any SecurableCollectionObserve {
        return obs.update(observe(for: observer))
    }
}

extension SecureMap: CustomReflectable, Sequence {
    public var customMirror: Mirror {
        return Mirror(self, children: [:])
    }
    
    public func makeIterator() -> Iterator {
        return wrp.sync { $0.makeIterator() }
    }
}



