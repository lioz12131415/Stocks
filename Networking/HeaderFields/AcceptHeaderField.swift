//
//  AcceptHeaderField.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
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



