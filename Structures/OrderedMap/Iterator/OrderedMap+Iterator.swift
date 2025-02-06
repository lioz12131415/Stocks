//
//  OrderedMap+Iterator.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension OrderedMap {
    public struct Iterator: IteratorProtocol {
        
        private let map:  Map
        private let keys: Keys
        
        private var current: Int = {
            return .zero
        }()
        
        internal init(keys: Keys, map: Map) {
            self.map  = map
            self.keys = keys
        }
        
        public mutating func next() -> (key: Key, value: Value)? {
            guard let key   = keys[safe: current],
                  let value = map[key] else {
                return nil
            }
            current += 1
            return (key: key, value: value)
        }
    }
}



