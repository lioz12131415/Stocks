//
//  Quote.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public struct Quote: Summary, Buildable {

    public var symbol:       String = .empty
    public var exchange:     String = .empty
    public var longName:     String = .empty
    public var typeDisp:     String = .empty
    public var currency:     String = .empty
    public var shortName:    String = .empty
    public var quoteType:    String = .empty
    public var fullExchange: String = .empty
    
    public var marketPrice:         MarketPrice = .empty
    public var marketChange:        MarketPrice = .empty
    public var marketPreviousClose: MarketPrice = .empty
    
    public var absoluteName: String {
        return !longName.isEmpty  ? longName  :
               !shortName.isEmpty ? shortName : .dash
    }
    
    public var exchangeDisplay: String {
        return [fullExchange.uppercased(), currency].filter {
            !$0.isEmpty
        }.joined(separator: " · ")
    }
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }
    
    @discardableResult
    public mutating func update(from json: JSON) -> Quote {
        return builder
            .set(json["symbol"].stringValue,               for: \.symbol)
            .set(json["exchange"].stringValue,             for: \.exchange)
            .set(json["longName"].stringValue,             for: \.longName)
            .set(json["currency"].stringValue,             for: \.currency)
            .set(json["typeDisp"].stringValue,             for: \.typeDisp)
            .set(json["shortName"].stringValue,            for: \.shortName)
            .set(json["quoteType"].stringValue,            for: \.quoteType)
            .set(json["fullExchange"].stringValue,         for: \.fullExchange)
            .set(.init(from: json["marketPrice"]),         for: \.marketPrice)
            .set(.init(from: json["marketChange"]),        for: \.marketChange)
            .set(.init(from: json["marketPreviousClose"]), for: \.marketPreviousClose)
            .build(into: &self)
    }
}

extension Quote {
    public static var empty: Quote {
        return Quote()
    }
}
