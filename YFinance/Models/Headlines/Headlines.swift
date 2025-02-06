//
//  Headlines.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public struct Headlines: Headlineable, Buildable, ExpressibleByArrayLiteral {

    fileprivate var elements: [Headline] = []
    
    private(set) public var link:        String = .empty
    private(set) public var title:       String = .empty
    private(set) public var symbol:      String = .empty
    private(set) public var dateCreated: String = .empty
    
    public var count: Int {
        return elements.count
    }
    
    public var endIndex: Int {
        return count
    }
    
    public var startIndex: Int {
        return .zero
    }
    
    public var last: Headline? {
        return elements.last
    }
    
    public var first: Headline? {
        return elements.first
    }
    
    public subscript(index: Int) -> Headline {
        return elements[index]
    }
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }
    
    public init(arrayLiteral elements: Headline...) {
        self.elements = elements
    }
    
    @discardableResult
    public mutating func update(from json: JSON) -> Headlines {
        self.elements = json["elements"].arrayValue.map {
            .init(from: $0)
        }
        return builder
            .set(json["link"].stringValue,        for: \.link)
            .set(json["title"].stringValue,       for: \.title)
            .set(json["symbol"].stringValue,      for: \.symbol)
            .set(json["dateCreated"].stringValue, for: \.dateCreated)
            .build(into: &self)
    }
}

extension Headlines: RandomAccessCollection, Collection, Sequence {
    
    public typealias Index    = Int
    public typealias Indices  = Range<Int>
    public typealias Iterator = Array<Headline>.Iterator
    
    public func makeIterator() -> Iterator {
        return elements.makeIterator()
    }
}

extension Headlines {
    public static var empty: Headlines {
        return Headlines()
    }
}
