//
//  AcceptHeaderField.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public struct AcceptHeaderField: HTTPHeaderField {
    
    public var raw: String {
        return "Accept"
    }
    
    public enum Value: HTTPHeaderValue {
        
        case all
        case json
        case string(_ value: String)
        
        public var raw: String {
            switch self {
                case .all:           return "*/*"
                case .json:          return "application/json"
                case .string(let v): return v
            }
        }
    }
}



