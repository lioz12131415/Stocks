//
//  ContentTypeHeaderField.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
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

