//
//  Metrics.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public protocol Metrics: Ticker {
    var longName:     String { get }
    var typeDisp:     String { get }
    var currency:     String { get }
    var fullExchange: String { get }
    
    var marketPrice:         MarketPrice { get }
    var marketChange:        MarketPrice { get }
    var marketPreviousClose: MarketPrice { get }
}
