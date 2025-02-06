//
//  QuoteEndpoints.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public enum QuoteEndpoints: Endpoint {
    
    case get(symbols: [String], crumb: String)
    
    public var host: String {
        return "https://query1.finance.yahoo.com/v7/finance/"
    }
    
    public var fields: QuoteRoute.Fields {
        return [.longName, .shortName, .marketCap, .regularMarketChange, .regularMarketPrice]
    }
    
    public var path: String {
        switch self {
            case .get(let s, let c):
                return QuoteRoute()
                    .crumb(c)
                    .symbols(s)
                    .fields(fields)
                    .formatted(false).path()
        }
    }
}
