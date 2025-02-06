//
//  ChartsTableCache.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import SecureData
import Foundation

final
public class ChartsTable: NSObject {
    
    public typealias Range       = Chart.Range
    public typealias Granularity = Chart.Granularity
    
    fileprivate var que: DispatchQueue
    fileprivate var elm: Dictionary<String, ChartsCache>
    
    internal override init() {
        self.elm = .init()
        self.que = .init(label: "charts.table.dispatch")
    }
    
    public subscript(range r: Range, granularity g: Granularity) -> ChartsCache {
        set { sync { $0.set(newValue) } }
        get { sync { $0.get(range: r, granularity: g) } }
    }
    
    public func save() {
        sync { $0.forEach { $0.value.save() } }
    }
}

extension ChartsTable {
    @discardableResult
    fileprivate func sync<V>(_ block: (inout [String: ChartsCache]) -> V) -> V {
        var value: V!
        que.sync {
            value = block(&elm)
        }
        return value
    }
}
