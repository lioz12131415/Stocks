//
//  OrderedMap.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public struct OrderedMap<Key: Hashable, Value>: ExpressibleByDictionaryLiteral, Sequence {
    
    public typealias Map  = Dictionary<Key, Value>
    public typealias Keys = ContiguousArray<Key>
    
    internal(set) public var map:  Map  = .init()
    internal(set) public var keys: Keys = .init()
    
    public var count: Int {
        return keys.count
    }
    
    public var last: Value? {
        return self[count-1]
    }
    
    public var first: Value? {
        return self[.zero]
    }
    
    public var isEmpty: Bool {
        return keys.isEmpty
    }
    
    public var values: [Value] {
        return compactMap { $0.1 }
    }
    
    public var items: [(key: Key, value: Value)] {
        return compactMap { (key: $0.0, value: $0.1) }
    }
    
    public subscript(key: Key) -> Value? {
        get { map[key] }
        set { _update(newValue, for: key) }
    }
    
    public subscript(index: Int) -> Value? {
        get { _get(index) }
        set { _set(newValue, for: index) }
    }
    
    public init() {
        /* */
    }
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        elements.forEach { self[$0.0] = $0.1 }
    }
    
    public mutating func removeAll() {
        self._removeAll()
    }
    
    public func makeIterator() -> Iterator {
        return Iterator(keys: keys, map: map)
    }
    
    public func contains(_ key: Key) -> Bool {
        return map[key] != nil
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
    public mutating func remove(for key: Key) -> Value? {
        return _update(nil, for: key)
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> Value? {
        self._remove(index)
    }

    @discardableResult
    public mutating func insert(_ value: Value, for key: Key, at index: Int) -> Value? {
        return _insert(value, for: key, at: index)
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
