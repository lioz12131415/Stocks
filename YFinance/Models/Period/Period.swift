//
//  Period.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public struct Period: Buildable, Codable {
    internal(set) public var timezone: String = .empty
    
    internal(set) public var end:       Int = .zero
    internal(set) public var start:     Int = .zero
    internal(set) public var gmtoffset: Int = .zero
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }

    @discardableResult
    public mutating func update(from json: JSON) -> Period {
        return builder
            .set(json["end"].intValue,         for: \.end)
            .set(json["start"].intValue,       for: \.start)
            .set(json["gmtoffset"].intValue,   for: \.gmtoffset)
            .set(json["timezone"].stringValue, for: \.timezone)
            .build(into: &self)
    }
}

extension Period {
    public static var empty: Period {
        return Period()
    }
}
