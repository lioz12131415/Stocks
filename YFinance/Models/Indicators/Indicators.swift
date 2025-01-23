//
//  Indicators.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public struct Indicators: Buildable, Codable {
    
    internal(set) public var low:    Indicator<Double> = .empty
    internal(set) public var high:   Indicator<Double> = .empty
    internal(set) public var open:   Indicator<Double> = .empty
    internal(set) public var close:  Indicator<Double> = .empty
    internal(set) public var volume: Indicator<Int>    = .empty
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }
    
    @discardableResult
    public mutating func update(from json: JSON) -> Indicators {
        return builder
            .set(.init(from: json["low"]),    for: \.low)
            .set(.init(from: json["high"]),   for: \.high)
            .set(.init(from: json["open"]),   for: \.open)
            .set(.init(from: json["close"]),  for: \.close)
            .set(.init(from: json["volume"]), for: \.volume)
            .build(into: &self)
    }
}

extension Indicators {
    public static var empty: Indicators {
        return Indicators()
    }
}
