//
//  Timeline.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public protocol Timeline: Ticker {
    
    typealias Range       = Chart.Range
    typealias Timestamp   = Indicator<Int>
    typealias Granularity = Chart.Granularity
    
    var range:         Range         { get }
    var timestamp:     Timestamp     { get }
    var indicators:    Indicators    { get }
    var granularity:   Granularity   { get }
    var tradingPeriod: TradingPeriod { get }
}


