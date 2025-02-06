//
//  Dictionary+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Dictionary where Key == String {
    internal func merge(_ other: Dictionary<String, Value>) -> Dictionary<Key, Value> {
        var result = self
        result.merge(other) { (_, new) in new }
        return result
    }
}

extension Dictionary where Key == String, Value == ChartsCache {
    @discardableResult mutating func set(_ newValue: Value) -> Value {
        self["\(newValue.range.rawValue).\(newValue.granularity.rawValue)"] = newValue
        return newValue
    }
}

extension Dictionary where Key == String, Value == ChartsCache {
    @discardableResult mutating func get(range: Chart.Range, granularity: Chart.Granularity) -> Value {
        guard let value = self["\(range.rawValue).\(granularity.rawValue)"] else {
            return set(.init(range: range, granularity: granularity))
        }
        return value
    }
}
