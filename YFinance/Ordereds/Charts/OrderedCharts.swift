//
//  OrderedCharts.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import TSCoreData
import Structures
import Foundation

@objc(OrderedCharts)
public class OrderedCharts: NSObject, NSSecureCoding {
    
    public typealias Range       = Chart.Range
    public typealias Granularity = Chart.Granularity
        
    private(set) var range:       Range       = .unowned
    private(set) var granularity: Granularity = .unowned
    
    public class var supportsSecureCoding: Bool {
        return true
    }
    
    public var count: Int {
        return elements.count
    }
    
    public var last: Chart? {
        return elements.last
    }
    
    public var first: Chart? {
        return elements.first
    }
    
    public var keys: [String] {
        return elements.keys
    }
    
    public var values: [Chart] {
        return elements.values
    }
    
    public override var description: String {
        return elements.description
    }
    
    public override var debugDescription: String {
        return elements.debugDescription
    }
    
    fileprivate var elements: Ordered<String, Chart> = [:] {
        didSet { /* * * */ }
    }
    
    public subscript(index: Int) -> Chart? {
        get { elements[index] }
        set { elements[index] = newValue }
    }
    
    public subscript(symbol: String) -> Chart? {
        get { elements[symbol] }
        set { elements[symbol] = newValue }
    }
    
    public override init() {
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init()
        self.elements    = aDecoder.decode(for: Key.elements)    ?? [:]
        self.range       = aDecoder.decode(for: Key.range)       ?? .unowned
        self.granularity = aDecoder.decode(for: Key.granularity) ?? .unowned
    }
    
    public init(_ range: Range, _ granularity: Granularity) {
        super.init()
        self.range       = range
        self.granularity = granularity
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(range,       for: Key.range)
        aCoder.encode(elements,    for: Key.elements)
        aCoder.encode(granularity, for: Key.granularity)
    }
    
    public func removeAll() {
        self.elements.removeAll()
    }
    
    public func remove(key: String) {
        self.elements.remove(for: key)
    }
    
    public func remove(at index: Int) {
        self.elements.remove(at: index)
    }
    
    public func contains(_ symbol: String) -> Bool {
        self.elements.contains(symbol)
    }
    
    public func observe(_ observer: NSObject) -> any OrderedObserve {
        return elements.observe(observer)
    }
             
    public func remove(_ chart: Chart) {
        guard chart.range == range, chart.granularity == granularity else {
            return
        }
        self.elements.remove(for: chart.symbol)
    }
    
    public func push(_ chart: Chart) {
        guard chart.range == range, chart.granularity == granularity else {
            return
        }
        self.elements.push(chart, for: chart.symbol)
    }
    
    public func update(_ chart: Chart) {
        guard chart.range == range, chart.granularity == granularity else {
            return
        }
        self.elements.update(chart, for: chart.symbol)
    }
    
    public func append(_ chart: Chart) {
        guard chart.range == range, chart.granularity == granularity else {
            return
        }
        self.elements.append(chart, for: chart.symbol)
    }
    
    public func insert(_ chart: Chart, at index: Int) {
        guard chart.range == range, chart.granularity == granularity else {
            return
        }
        self.elements.insert(chart, for: chart.symbol, at: index)
    }
}

extension OrderedCharts {
    public func save(_ type: TSSave<ChartsCache>) {
        ChartsCache.save(type)
        elements.notify(.saved)
    }
}

extension OrderedCharts {
    public static var empty: OrderedCharts {
        return OrderedCharts()
    }
}

extension OrderedCharts {
    enum Key: String {
        case range       = "range"
        case elements    = "elements"
        case granularity = "granularity"
    }
}
