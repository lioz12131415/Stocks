//
//  Indicator.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public struct Indicator<Number: Numberable>: Codable, Buildable {
    
    public typealias Numbers = [Number]
    
    public var min: Number  = .zero
    public var max: Number  = .zero
    public var all: Numbers = []
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }
    
    @discardableResult
    public mutating func update(from json: JSON) -> Indicator<Number> {
        return builder
            .set((json["min"].number as? Number) ?? .zero, for: \.min)
            .set((json["max"].number as? Number) ?? .zero, for: \.max)
            .set((json["all"].arrayValue).compactMap { Number($0.number) }, for: \.all)
            .build(into: &self)
    }
}

extension Indicator {
    public static var empty: Indicator<Number> {
        return Indicator<Number>()
    }
}
