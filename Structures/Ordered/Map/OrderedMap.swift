//
//  OrderedMap.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public struct OrderedMap<Key: Hashable, Value>: ExpressibleByDictionaryLiteral {
    
    internal var _keys: ContiguousArray<Key>  = []
    internal var _dict: Dictionary<Key, Value> = [:]
    
    public var count: Int {
        return _keys.count
    }
    
    public var last: Value? {
        return self[count-1]
    }
    
    public var first: Value? {
        return self[.zero]
    }
    
    public var keys: [Key] {
        return _keys.map { $0 }
    }
    
    public var values: [Value] {
        return compactMap { $0.1 }
    }
    
    public var items: [(key: Key, value: Value)] {
        return compactMap { (key: $0.0, value: $0.1) }
    }
    
    public init() {
        /* */
    }
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        elements.forEach { self[$0.0] = $0.1 }
    }
    
    public subscript(key: Key) -> Value? {
        get { _dict[key] }
        set { _update(newValue, for: key) }
    }
    
    public subscript(index: Int) -> Value? {
        get { _get(index) }
        set { _set(newValue, for: index) }
    }
    
    public subscript(key: Key, default d: Value) -> Value {
        get { _dict[key] ?? d }
    }
    
    public mutating func removeAll() {
        self._dict.removeAll()
        self._keys.removeAll()
    }
    
    public func contains(_ key: Key) -> Bool {
        return _dict[key] != nil
    }
    
    public mutating func push(_ value: Value, for key: Key) {
        self._insert(value, for: key, at: .zero)
    }
    
    public mutating func update(_ value: Value, for key: Key) {
        self._update(value, for: key)
    }
    
    public mutating func append(_ value: Value, for key: Key) {
        self._update(value, for: key)
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> Value? {
        self._remove(index)
    }
    
    @discardableResult
    public mutating func remove(for key: Key) -> Value? {
        return _update(nil, for: key)
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, for key: Key, at index: Int) -> Value? {
        return _insert(value, for: key, at: index)
    }
}

extension OrderedMap: Sequence {
    public func makeIterator() -> Iterator {
        return Iterator(keys: _keys, dict: _dict)
    }
}

extension OrderedMap: CustomReflectable, CustomStringConvertible, CustomDebugStringConvertible {
    public var customMirror: Mirror {
        return Mirror(self, children: [:])
    }
    
    public var description: String {
        return Dictionary(uniqueKeysWithValues: map { $0 }).description
    }
    
    public var debugDescription: String {
        return Dictionary(uniqueKeysWithValues: map { $0 }).debugDescription
    }
}

