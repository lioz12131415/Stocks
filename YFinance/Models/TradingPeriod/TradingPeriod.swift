//
//  TradingPeriod.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking

public struct TradingPeriod: Buildable, Codable {
    
    public var pre:     Period  = .empty
    public var post:    Period  = .empty
    public var regular: Period  = .empty
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }

    @discardableResult
    public mutating func update(from json: JSON) -> TradingPeriod {
        return builder
            .set(.init(from: json["pre"]),     for: \.pre)
            .set(.init(from: json["post"]),    for: \.post)
            .set(.init(from: json["regular"]), for: \.regular)
            .build(into: &self)
    }
}

extension TradingPeriod {
    public static var empty: TradingPeriod {
        return TradingPeriod()
    }
}
