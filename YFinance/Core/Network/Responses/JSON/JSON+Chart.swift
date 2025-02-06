//
//  JSON+Chart.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

extension JSON {
    public struct Chart: Responseable {
        public static func rewrite(from decoder: Decoder) -> JSON {
            let json       = try? JSON(from: decoder)
            let chart      = json?["chart"] ?? .null
            let adjustment = chart["result"][0].adjustment()
            return JSON(adjustment.comprehensive())
        }
    }
}

extension JSON {
    fileprivate func adjustment() -> JSON {
        let meta   = self["meta"]
        let quote  = self["indicators"]["quote"][0]
        let price  = meta["regularMarketPrice"].doubleValue
        let close  = meta["chartPreviousClose"].doubleValue
        let change = close == 0.0 ? 0.0 : price-close
        
        return JSON([
            "range":                      JSON(meta["range"].stringValue),
            "symbol":                     JSON(meta["symbol"].stringValue),
            "currency":                   JSON(meta["currency"].stringValue),
            "longName":                   JSON(meta["longName"].stringValue),
            "shortName":                  JSON(meta["shortName"].stringValue),
            "granularity":                JSON(meta["dataGranularity"].stringValue),
            "fullExchangeName":           JSON(meta["fullExchangeName"].stringValue),
            "regularMarketPrice":         JSON(meta["regularMarketPrice"].doubleValue),
            "regularMarketPreviousClose": JSON(meta["chartPreviousClose"].doubleValue),
                    
            "indicators": [
                "low":    indicator(quote["low"].arrayValue.compactMap(\.double)),
                "high":   indicator(quote["high"].arrayValue.compactMap(\.double)),
                "open":   indicator(quote["open"].arrayValue.compactMap(\.double)),
                "close":  indicator(quote["close"].arrayValue.compactMap(\.double)),
                "volume": indicator(quote["volume"].arrayValue.compactMap(\.int)),
            ],
            
            "regularMarketChange": JSON(change),
            "tradingPeriod":       JSON(meta["currentTradingPeriod"]),
            "timestamp":           indicator(self["timestamp"].arrayValue.compactMap(\.int)),
        ])
    }
    
    fileprivate func indicator(_ numbers: [Int]) -> JSON {
        return [
            "all": JSON(numbers),
            "min": JSON(numbers.min()),
            "max": JSON(numbers.max()),
        ]
    }
    
    fileprivate func indicator(_ numbers: [Double]) -> JSON {
        return [
            "all": JSON(numbers),
            "min": JSON(numbers.min()),
            "max": JSON(numbers.max()),
        ]
    }
}
