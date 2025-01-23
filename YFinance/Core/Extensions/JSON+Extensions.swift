//
//  JSON+Extensions.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

extension JSON {
    public func summary() -> Dictionary<String, JSON> {
        return profile().merge(metrics())
    }
}

extension JSON {
    public func comprehensive() -> Dictionary<String, JSON> {
        return timeline().merge(summary())
    }
}

extension JSON {
    public func profile() -> Dictionary<String, JSON> {
        return [
            "symbol":    JSON(self["symbol"].stringValue),
            "exchange":  JSON(self["exchange"].stringValue),
            "quoteType": JSON(self["quoteType"].stringValue),
            "shortName": JSON(self["shortName"].stringValue),
        ]
    }
}

extension JSON {
    public func marketPrice() -> Dictionary<String, JSON> {
        return [
            "raw": JSON(doubleValue),
            "fmt": JSON(doubleValue.fmt()),
            "sgn": JSON(doubleValue.sgn()),
        ]
    }
}

extension JSON {
    public func metrics() -> Dictionary<String, JSON> {
        let price  = self["regularMarketPrice"].doubleValue
        let close  = self["regularMarketPreviousClose"].doubleValue
        let change = close == 0.0 ? 0.0 : price-close
        return [
            "typeDisp":            JSON(self["typeDisp"].stringValue),
            "currency":            JSON(self["currency"].stringValue),
            "longName":            JSON(self["longName"].stringValue),
            "fullExchange":        JSON(self["fullExchangeName"].stringValue),
            "marketPrice":         JSON(JSON(price).marketPrice()),
            "marketChange":        JSON(JSON(change).marketPrice()),
            "marketPreviousClose": JSON(JSON(close).marketPrice()),
        ]
    }
}

extension JSON {
    public func timeline() -> Dictionary<String, JSON> {
        return [
            "range":               JSON(self["range"]),
            "timestamp":           JSON(self["timestamp"]),
            "indicators":          JSON(self["indicators"]),
            "granularity":         JSON(self["granularity"]),
            "tradingPeriod":       JSON(self["tradingPeriod"]),
        ]
    }
}
