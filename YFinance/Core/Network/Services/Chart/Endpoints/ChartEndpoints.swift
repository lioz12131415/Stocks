//
//  ChartEndpoints.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public enum ChartEndpoints: Endpoint {
    
    public typealias Range       = Chart.Range
    public typealias Granularity = Chart.Granularity
    
    case get(symbol: String, range: Range, granularity: Granularity)
    
    public var host: String {
        return "https://query1.finance.yahoo.com/v8/finance/"
    }
    
    public var path: String {
        switch self {
            case .get(let s, let r, let g):
                return ChartRoute()
                        .range(r)
                        .symbol(s)
                        .granularity(g).path()
        }
    }
}
