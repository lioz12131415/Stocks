//
//  JSON.swift
//  Networking
//
//  Created by ליעוז בלקי on 22/12/2024.
//

import Foundation

public struct JSON: Codable {
    
    internal var object: JSONObject? = nil
    
    public var int: Int? {
        return object?.int
    }
    
    public var double: Double? {
        return object?.double
    }
    
    public var any: JSONObject? {
        return object
    }
    
    public var number: NSNumber? {
        return object?.number
    }
    
    public var intValue: Int {
        get { object?.int ?? .zero }
        set { if let o = object, o.isInt { object = newValue } }
    }
        
    public var arrayValue: [JSON] {
        get { object?.array ?? [] }
        set { if let o = object, o.isArray { object = newValue } }
    }
        
    public var doubleValue: Double {
        get { object?.double ?? .zero }
        set { if let o = object, o.isDouble { object = newValue } }
    }
    
    public var stringValue: String {
        get { object?.string ?? .empty }
        set { if let o = object, o.isString { object = newValue } }
    }
        
    public var dictionaryValue: [String: JSON] {
        get { object?.dictionary ?? [:] }
        set { if let o = object, o.isDictionary { object = newValue } }
    }
    
    public init(_ json: JSON?) {
        self.object = json?.object
    }
    

    public init(_ jsons: [JSON]) {
        self.object = jsons
    }
    
    public init(_ object: JSONObject?) {
        self.object = object
    }
    
    public init(_ objects: [JSONObject]) {
        self.object = objects.map { JSON($0)}
    }
   
    public init(from data: Data) throws {
        self.object = data.jsonObjectValue
    }
    
    public init(from decoder: Decoder) throws {
        self.object = decoder.jsonObjectValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try encoder.encode(object)
    }
    
    public subscript(key: String) -> JSON {
        get { object?.dictionary?[key] ?? .null }
        set { object?.dictionary?[key] = newValue }
    }
    
    public subscript(index: Int) -> JSON {
        get { object?.array?[index] ?? .null }
        set { object?.array?[index] = newValue }
    }
    
    public subscript(safe index: Int) -> JSON {
        get { object?.array?[safe: index] ?? .null }
        set { object?.array?[safe: index] = newValue }
    }
    
    public func dataValue() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    public func value<T>(_ type: T.Type) -> T? {
        return object as? T
    }
        
    public func values<T>(_ type: T.Type) -> [T] {
        return arrayValue.compactMap { $0.object as? T }
    }
    
    public func double(or value: Double) -> Double {
        return object?.double ?? value
    }
    
    public func string(or value: String) -> String {
        return object?.string ?? value
    }
    
    public mutating func change(key oldKey: String, to newKey: String) {
        if let value = dictionaryValue[oldKey] {
            dictionaryValue[newKey] = value
            dictionaryValue[oldKey] = nil
        }
    }
}

extension JSON: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    public var description: String {
        return .prettyDescription(self)
    }

    public var customMirror: Mirror {
        return Mirror(self, children: [:])
    }
    
    public var debugDescription: String {
        return .prettyDescription(self)
    }
}

extension JSON: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.object = value
    }
}

extension JSON: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.object = value
    }
}

extension JSON: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self.object = value
    }
}

extension JSON: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self.object = value
    }
}

extension JSON: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, JSON)...) {
        self.object = [String: JSON](uniqueKeysWithValues: elements)
    }
}

extension JSON {
    public static var null: JSON {
        return JSON()
    }
}
