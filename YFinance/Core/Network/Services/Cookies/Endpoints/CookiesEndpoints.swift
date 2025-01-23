//
//  CookiesEndpoints.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

enum CookiesEndpoints: Endpoint {
    
    case get
    
    var host: String {
        return "https://fc.yahoo.com"
    }
    
    var path: String {
        return "/"
    }
}
