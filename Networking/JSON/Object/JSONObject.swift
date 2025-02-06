//
//  JSONObject.swift
//  Networking
//
//  Created by ליעוז בלקי on 22/12/2024.
//

import Foundation

infix operator <- : AssignmentPrecedence

public protocol JSONObject: Codable {
    
}

extension Int:   JSONObject { }
extension Int8:  JSONObject { }
extension Int16: JSONObject { }
extension Int32: JSONObject { }
extension Int64: JSONObject { }

extension UInt:   JSONObject { }
extension UInt8:  JSONObject { }
extension UInt16: JSONObject { }
extension UInt32: JSONObject { }
extension UInt64: JSONObject { }

extension Bool:   JSONObject { }
extension Double: JSONObject { }
extension String: JSONObject { }

extension Array:      JSONObject where Element == JSON { }
extension Dictionary: JSONObject where Key == String, Value == JSON { }

extension JSONObject {
    internal var isInt:        Bool { self is Int      }
    internal var isArray:      Bool { self is [JSON]   }
    internal var isDouble:     Bool { self is Double   }
    internal var isString:     Bool { self is String   }
    internal var isNumber:     Bool { self is NSNumber }
    internal var isDictionary: Bool { self is [String: JSON] }
}

extension JSONObject {
    internal var int: Int? {
        set { self <- newValue }
        get { self.number?.intValue }
    }
    
    internal var double: Double? {
        set { self <- newValue }
        get { self.number?.doubleValue }
    }
    
    internal var string: String? {
        get { self as? String }
        set { self <- newValue }
    }
    
    internal var array: [JSON]? {
        get { self as? [JSON] }
        set { self <- newValue }
    }
    
    internal var number: NSNumber? {
        return self as? NSNumber
    }
    
    internal var dictionary: [String: JSON]? {
        set { self <- newValue }
        get { self as? [String: JSON] }
    }
}

