//
//  ContentTypeHeaderField.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public struct ContentTypeHeaderField: HTTPHeaderField {
    
    public var raw: String {
        return "Content-Type"
    }
    
    public enum Value: HTTPHeaderValue {
        
        case json
        case string(_ value: String)
        
        public var raw: String {
            switch self {
                case .json:          return "application/json"
                case .string(let v): return v
            }
        }
    }
}

