//
//  OrderedQuotes.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import TSCoreData
import Structures
import Foundation

@objc(OrderedQuotes)
public class OrderedQuotes: NSObject, NSSecureCoding {
        
    public var count: Int {
        return elements.count
    }
    
    public var last: Quote? {
        return elements.last
    }
    
    public var first: Quote? {
        return elements.first
    }
    
    public var keys: [String] {
        return elements.keys
    }
    
    public var values: [Quote] {
        return elements.values
    }
    
    public override var description: String {
        return elements.description
    }
    
    public class var supportsSecureCoding: Bool {
        return true
    }
    
    public override var debugDescription: String {
        return elements.debugDescription
    }
    
    fileprivate var elements: Ordered<String, Quote> = [:] {
        didSet { /* * * */ }
    }
    
    public subscript(index: Int) -> Quote? {
        get { elements[index] }
        set { elements[index] = newValue }
    }
    
    public subscript(symbol: String) -> Quote? {
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
    
    public func remove(_ quote: Quote) {
        self.elements.remove(for: quote.symbol)
    }
                
    public func push(_ quote: Quote) {
        self.elements.push(quote, for: quote.symbol)
    }
    
    public func update(_ quote: Quote) {
        self.elements.update(quote, for: quote.symbol)
    }
    
    public func append(_ quote: Quote) {
        self.elements.append(quote, for: quote.symbol)
    }
    
    public func contains(_ quote: Quote) -> Bool {
        self.elements.contains(quote.symbol)
    }
    
    public func contains(_ symbol: String) -> Bool {
        self.elements.contains(symbol)
    }

    public func insert(_ quote: Quote, at index: Int) {
        self.elements.insert(quote, for: quote.symbol, at: index)
    }
    
    public func observe(_ observer: NSObject) -> any OrderedObserve {
        return elements.observe(observer)
    }
}

extension OrderedQuotes {
    public func save(_ type: TSSave<QuotesCache>) {
        QuotesCache.save(type)
        elements.notify(.saved)
    }
}

extension OrderedQuotes {
    public static var empty: OrderedQuotes {
        return OrderedQuotes()
    }
}

extension OrderedQuotes {
    enum Key: String {
        case elements = "elements"
    }
}


