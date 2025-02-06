//
//  SingleValueDecodingContainer+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 22/12/2024.
//

import Foundation

extension SingleValueDecodingContainer {
    internal var jsonObjectValue: JSONObject? {
        guard !decodeNil() else {
            return nil
        }
        if let value = try? decode(Bool.self) {
            return value
        }
        else if let value = try? decode(Int.self)   { return value }
        else if let value = try? decode(Int8.self)  { return value }
        else if let value = try? decode(Int32.self) { return value }
        else if let value = try? decode(Int64.self) { return value }
        
        else if let value = try? decode(UInt.self)   { return value }
        else if let value = try? decode(UInt8.self)  { return value }
        else if let value = try? decode(UInt16.self) { return value }
        else if let value = try? decode(UInt32.self) { return value }
        else if let value = try? decode(UInt64.self) { return value }
        
        else if let value = try? decode(Double.self) { return value }
        else if let value = try? decode(String.self) { return value }
        
        else if let value = try? decode([JSON].self)         { return value }
        else if let value = try? decode([String: JSON].self) { return value }
        
        return nil
    }
}

