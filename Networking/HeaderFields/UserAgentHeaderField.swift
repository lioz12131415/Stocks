//
//  UserAgentHeaderField.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
//

import Foundation

public struct UserAgentHeaderField: HTTPHeaderField {
    
    public var raw: String {
        return "User-Agent"
    }
    
    public enum Value: HTTPHeaderValue {
        
        case mozilla
        case string(_ value: String)
        
        public var raw: String {
            switch self {
                case .mozilla:       return "Mozilla/5.0 (Windows NT 6.1; Win64; x64)"
                case .string(let v): return v
            }
        }
    }
}

