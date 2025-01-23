//
//  OrderedMap+Internal.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension OrderedMap {
    @discardableResult
    internal func _get(_ index: Int) -> Value? {
        let key   = _keys[safe: index]
        let value = _dict[safe: key]
        return value
    }
    
    @discardableResult
    internal mutating func _remove(_ index: Int) -> Value? {
        guard let key = _keys[safe: index] else {
            return nil
        }
        return _update(nil, for: key)
    }
    
    
    @discardableResult
    internal mutating func _remove(_ value: Value, for key: Key) -> Value? {
        guard let index = _keys.firstIndex(of: key) else {
            return nil
        }
        self._keys.remove(at: index)
        self._dict.removeValue(forKey: key)
        return value
    }

    @discardableResult
    internal mutating func _set(_ newValue: Value?, for key: Key) -> Value? {
        guard let newValue = newValue else {
            return nil
        }
        self._keys.append(key)
        self._dict[key] = newValue
        return newValue
    }
    

    @discardableResult
    internal mutating func _set(_ newValue: Value?, for index: Int) -> Value? {
        guard let key = _keys[safe: index] else {
            return nil
        }
        return _update(newValue, for: key)
    }
    
    @discardableResult
    internal mutating func _update(_ newValue: Value?, for key: Key) -> Value? {
        guard let node = _dict[key] else {
            return _set(newValue, for: key)
        }
        guard let newValue = newValue else {
            return _remove(node, for: key)
        }
        _dict[key] = newValue
        return newValue
    }
    
    @discardableResult
    internal mutating func _insert(_ newValue: Value, for key: Key, at index: Int) -> Value? {
        if _dict[key] != nil, let index = _keys.firstIndex(of: key) {
            _keys.remove(at: index)
        }
        _keys.insert(key, at: index)
        _dict[key] = newValue
        return newValue
    }
}
