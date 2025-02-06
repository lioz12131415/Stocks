//
//  CrumbEndpoints.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public enum CrumbEndpoints: Endpoint {
    
    case get
    
    public var host: String {
        return "https://query2.finance.yahoo.com/v1/"
    }
    
    public var path: String {
        return "test/getcrumb"
    }
}
