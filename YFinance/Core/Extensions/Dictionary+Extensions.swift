//
//  Dictionary+Extensions.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Dictionary where Key == String {
    internal func merge(_ other: Dictionary<String, Value>) -> Dictionary<Key, Value> {
        var result = self
        result.merge(other) { (_, new) in new }
        return result
    }
}

extension Dictionary where Key == String {
    @discardableResult
    internal mutating func update(_ value: Value, for key: Key) -> Value {
        guard let value = updateValue(value, forKey: key) else {
            return value
        }
        return value
    }
}

extension Dictionary where Key == String, Value == OrderedCharts {
    @discardableResult
    internal mutating func value(range r: Chart.Range, granularity g: Chart.Granularity) -> Value {
        guard let value = self["\(r.rawValue)\(g.rawValue)"] else {
            return update(OrderedCharts(r, g), for: "\(r.rawValue)\(g.rawValue)")
        }
        return value
    }
}

