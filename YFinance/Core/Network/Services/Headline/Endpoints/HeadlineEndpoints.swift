//
//  HeadlineEndpoints.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public enum HeadlineEndpoints: Endpoint {
    
    case get(symbol: String)
    
    public var host: String {
        return "https://feeds.finance.yahoo.com/rss/2.0/"
    }
    
    public var path: String {
        switch self {
            case .get(let s):
                return HeadlineRoute()
                        .symbol(s)
                        .path()
        }
    }
}
