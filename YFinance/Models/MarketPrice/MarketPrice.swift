//
//  MarketPrice.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public struct MarketPrice: Market {

    public var raw: Double = .zero
    public var fmt: String = .dash
    public var sgn: String = .dash
    
    public init() {
        /* * * * */
    }
    
    public init(from json: JSON) {
        self.raw = json["raw"].doubleValue
        self.fmt = json["fmt"].stringValue
        self.sgn = json["sgn"].stringValue
    }
    
    public init(from value: Double) {
        self.raw = value
        self.fmt = value.fmt()
        self.sgn = value.sgn()
    }
}

