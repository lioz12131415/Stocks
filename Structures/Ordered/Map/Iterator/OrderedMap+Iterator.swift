//
//  OrderedMap+Iterator.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension OrderedMap {
    public struct Iterator: IteratorProtocol {
        
        private let keys: ContiguousArray<Key>
        private let dict: Dictionary<Key, Value>
        
        private var current: Int = {
            return .zero
        }()
        
        internal init(keys: ContiguousArray<Key>, dict: Dictionary<Key, Value>) {
            self.keys = keys
            self.dict = dict
        }
        
        public mutating func next() -> (key: Key, value: Value)? {
            guard let key   = keys[safe: current],
                  let value = dict[key] else {
                return nil
            }
            current += 1
            return (key: key, value: value)
        }
    }
}

extension ContiguousArray {
    internal subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else {
            return nil
        }
        return self[index]
    }
}
