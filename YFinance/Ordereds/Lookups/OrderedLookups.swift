//
//  OrderedLookups.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import TSCoreData
import Structures
import Foundation

@objc(OrderedLookups)
public class OrderedLookups: NSObject, NSSecureCoding {
        
    public var count: Int {
        return elements.count
    }
    
    public var last: Lookup? {
        return elements.last
    }
    
    public var first: Lookup? {
        return elements.first
    }
    
    public var keys: [String] {
        return elements.keys
    }
    
    public var values: [Lookup] {
        return elements.values
    }
    
    public override var description: String {
        return elements.description
    }
    
    public override var debugDescription: String {
        return elements.debugDescription
    }
    
    public class var supportsSecureCoding: Bool {
        return true
    }
    
    fileprivate var elements: Ordered<String, Lookup> = [:] {
        didSet { /* * * */ }
    }
    
    public subscript(index: Int) -> Lookup? {
        get { elements[index] }
        set { elements[index] = newValue }
    }
    
    public subscript(symbol: String) -> Lookup? {
        get { elements[symbol] }
        set { elements[symbol] = newValue }
    }
    
    public override init() {
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init()
        self.elements = aDecoder.decode(for: Key.elements) ?? [:]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(elements, for: Key.elements)
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
    
    public func remove(_ lookup: Lookup) {
        self.elements.remove(for: lookup.symbol)
    }
                
    public func push(_ lookup: Lookup) {
        self.elements.push(lookup, for: lookup.symbol)
    }
    
    public func update(_ lookup: Lookup) {
        self.elements.update(lookup, for: lookup.symbol)
    }
    
    public func append(_ lookup: Lookup) {
        self.elements.append(lookup, for: lookup.symbol)
    }
        
    public func contains(_ symbol: String) -> Bool {
        self.elements.contains(symbol)
    }
    
    public func insert(_ lookup: Lookup, at index: Int) {
        self.elements.insert(lookup, for: lookup.symbol, at: index)
    }
    
    public func observe(_ observer: NSObject) -> any OrderedObserve {
        return elements.observe(observer)
    }
}

extension OrderedLookups {
    public func save(_ type: TSSave<LookupsCache>) {
        LookupsCache.save(type)
        elements.notify(.saved)
    }
}

extension OrderedLookups {
    public static var empty: OrderedLookups {
        return OrderedLookups()
    }
}

extension OrderedLookups {
    enum Key: String {
        case elements = "elements"
    }
}
