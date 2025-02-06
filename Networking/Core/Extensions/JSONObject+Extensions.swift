//
//  JSONObject+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 30/12/2024.
//

import Foundation

extension JSONObject {
    internal static func <-(lhs: inout Self, rhs: JSONObject?) {
        guard let newValue = rhs as? Self else {
            return
        }
        lhs = newValue
    }
}

extension JSONObject {
    public func isEqual(to other: JSONObject?) -> Bool {
        switch (self, other) {
            case let (lhs as Int, rhs as Int):       return lhs == rhs
            case let (lhs as UInt, rhs as UInt):     return lhs == rhs
            case let (lhs as Bool, rhs as Bool):     return lhs == rhs
            case let (lhs as Int8, rhs as Int8):     return lhs == rhs
            case let (lhs as Int16, rhs as Int16):   return lhs == rhs
            case let (lhs as Int32, rhs as Int32):   return lhs == rhs
            case let (lhs as Int64, rhs as Int64):   return lhs == rhs
            case let (lhs as UInt8, rhs as UInt8):   return lhs == rhs
            case let (lhs as UInt16, rhs as UInt16): return lhs == rhs
            case let (lhs as UInt32, rhs as UInt32): return lhs == rhs
            case let (lhs as UInt64, rhs as UInt64): return lhs == rhs
            case let (lhs as Double, rhs as Double): return lhs == rhs
            case let (lhs as String, rhs as String): return lhs == rhs
            case let (lhs as [JSON], rhs as [JSON]): return lhs == rhs
            case let (lhs as [String: JSON], rhs as [String: JSON]): return lhs == rhs
        default:
            return false
        }
    }
}

extension JSONObject {
    public func isLess(than other: JSONObject?) -> Bool {
        switch (self, other) {
            case let (lhs as Int, rhs as Int):       return lhs < rhs
            case let (lhs as UInt, rhs as UInt):     return lhs < rhs
            case let (lhs as Int8, rhs as Int8):     return lhs < rhs
            case let (lhs as Int16, rhs as Int16):   return lhs < rhs
            case let (lhs as Int32, rhs as Int32):   return lhs < rhs
            case let (lhs as Int64, rhs as Int64):   return lhs < rhs
            case let (lhs as UInt8, rhs as UInt8):   return lhs < rhs
            case let (lhs as UInt16, rhs as UInt16): return lhs < rhs
            case let (lhs as UInt32, rhs as UInt32): return lhs < rhs
            case let (lhs as UInt64, rhs as UInt64): return lhs < rhs
            case let (lhs as Double, rhs as Double): return lhs < rhs
            case let (lhs as String, rhs as String): return lhs < rhs
        default:
            return false
        }
    }
}
