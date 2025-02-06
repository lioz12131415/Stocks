//
//  LookupEndpoints.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public enum LookupEndpoints: Endpoint {
    
    case get(query: String)
    
    public var host: String {
        return "https://query1.finance.yahoo.com/v1/finance/"
    }
    
    public var path: String {
        switch self {
            case .get(let q):
                return LookupRoute()
                    .query(q)
                    .types(.all)
                    .pricing(false)
                    .formatted(false).path()
        }
    }
}
