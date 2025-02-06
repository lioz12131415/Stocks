//
//  OrderedMap+Internal.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension OrderedMap {
    internal mutating func _removeAll() {
        self.map.removeAll()
        self.keys.removeAll()
    }
}

extension OrderedMap {
    @discardableResult
    internal func _get(_ index: Int) -> Value? {
        let key   = keys[safe: index]
        let value = map[safe: key]
        return value
    }
}

extension OrderedMap {
    @discardableResult
    internal mutating func _remove(_ index: Int) -> Value? {
        guard let key = keys[safe: index] else {
            return nil
        }
        return _update(nil, for: key)
    }
}

extension OrderedMap {
    @discardableResult
    internal mutating func _remove(_ value: Value, for key: Key) -> Value? {
        guard let index = keys.firstIndex(of: key) else {
            return nil
        }
        self.keys.remove(at: index)
        self.map.removeValue(forKey: key)
        return value
    }
}

extension OrderedMap {
    @discardableResult
    internal mutating func _set(_ newValue: Value?, for key: Key) -> Value? {
        guard let newValue = newValue else {
            return nil
        }
        self.keys.append(key)
        self.map[key] = newValue
        return newValue
    }
}

extension OrderedMap {
    @discardableResult
    internal mutating func _set(_ newValue: Value?, for index: Int) -> Value? {
        guard let key = keys[safe: index] else {
            return nil
        }
        return _update(newValue, for: key)
    }
}

extension OrderedMap {
    @discardableResult
    internal mutating func _update(_ newValue: Value?, for key: Key) -> Value? {
        guard let value = map[key] else {
            return _set(newValue, for: key)
        }
        guard let newValue = newValue else {
            return _remove(value, for: key)
        }
        map[key] = newValue
        return newValue
    }
}

extension OrderedMap {
    @discardableResult
    internal mutating func _insert(_ newValue: Value, for key: Key, at index: Int) -> Value? {
        if map[key] != nil, let index = keys.firstIndex(of: key) {
            keys.remove(at: index)
        }
        keys.insert(key, at: index)
        map[key] = newValue
        return newValue
    }
}
