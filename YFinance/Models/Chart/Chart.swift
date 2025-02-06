//
//  Chart.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public struct Chart: Comprehensive, Buildable {
    
    public var symbol:       String = .empty
    public var exchange:     String = .empty
    public var longName:     String = .empty
    public var typeDisp:     String = .empty
    public var currency:     String = .empty
    public var shortName:    String = .empty
    public var quoteType:    String = .empty
    public var fullExchange: String = .empty
        
    public var timestamp:     Timestamp     = .empty
    public var indicators:    Indicators    = .empty
    public var tradingPeriod: TradingPeriod = .empty
    
    public var marketPrice:         MarketPrice = .empty
    public var marketChange:        MarketPrice = .empty
    public var marketPreviousClose: MarketPrice = .empty
    
    public var range:       Range         = .unowned
    public var granularity: Granularity   = .unowned
    
    public var absoluteName: String {
        return !longName.isEmpty  ? longName  :
               !shortName.isEmpty ? shortName : .dash
    }
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }
    
    @discardableResult
    public mutating func update(from json: JSON) -> Chart {
        return builder
            .set(json["symbol"].stringValue,       for: \.symbol)
            .set(json["longName"].stringValue,     for: \.longName)
            .set(json["currency"].stringValue,     for: \.currency)
            .set(json["typeDisp"].stringValue,     for: \.typeDisp)
            .set(json["shortName"].stringValue,    for: \.shortName)
            .set(json["quoteType"].stringValue,    for: \.quoteType)
            .set(json["fullExchange"].stringValue, for: \.fullExchange)
        
            .set(.init(from: json["range"]),               for: \.range)
            .set(.init(from: json["timestamp"]),           for: \.timestamp)
            .set(.init(from: json["indicators"]),          for: \.indicators)
            .set(.init(from: json["granularity"]),         for: \.granularity)
            .set(.init(from: json["marketPrice"]),         for: \.marketPrice)
            .set(.init(from: json["marketChange"]),        for: \.marketChange)
            .set(.init(from: json["tradingPeriod"]),       for: \.tradingPeriod)
            .set(.init(from: json["marketPreviousClose"]), for: \.marketPreviousClose)
            .build(into: &self)
    }
}

extension Chart {
    public static var empty: Chart {
        return Chart()
    }
}
