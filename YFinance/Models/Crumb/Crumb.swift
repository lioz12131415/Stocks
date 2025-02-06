//
//  Crumb.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import SecureData
import Foundation

public struct Crumb: Codable, Securable {
    
    internal(set) public var key:         String = .empty
    internal(set) public var name:        String = .empty
    internal(set) public var domain:      String = .empty
    internal(set) public var expiresDate: Date?
    
    public init() {
        
    }
}

extension Crumb {
    internal static var empty: Crumb {
        return Crumb()
    }
}
