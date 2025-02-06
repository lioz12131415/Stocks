//
//  XML.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public struct XML {
    
    internal var value: XMLValue?
    
    public var intValue: Int {
        return int ?? .zero
    }
    
    public var tagValue: Tag {
        return tag ?? .null
    }
    
    public var tagsValue: [Tag] {
        return tags ?? []
    }
    
    public var doubleValue: Double {
        return double ?? .zero
    }
    
    public var stringValue: String {
        return string ?? ""
    }
    
    public var numberValue: NSNumber? {
        return number ?? NSNumber(0)
    }
    
    public var int: Int? {
        return value?.asInt
    }
    
    public var tag: Tag? {
        return value?.asTag
    }
    
    public var tags: [Tag]? {
        return value?.asTags
    }
    
    public var double: Double? {
        return value?.asDouble
    }
    
    public var string: String? {
        return value?.asString
    }
    
    public var number: NSNumber? {
        return value?.asNumber
    }
        
    public subscript(index: Int) -> XML {
        return value?.asTags[index].asXML ?? .null
    }
    
    public init() {
        /* * * */
    }
    
    public init(_ data: Data) {
        self.value = data.xmlValue
    }
    
    internal init(_ string: String) {
        self.value = string.xmlValue
    }

    internal init(_ tags: Array<Tag>?) {
        self.value = tags ?? []
    }
    
    internal init(_ xmlValue: XMLValue?) {
        self.value = xmlValue
    }
    
    public func first(_ tag: String) -> XML {
        return value?.first(tag).asXML ?? .null
    }
    
    public func select(_ tag: String) -> XML {
        return value?.select(tag).asXML ?? .null
    }
}

extension XML: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    public var description: String {
        return value?.prettyDescription(0) ?? ""
    }

    public var customMirror: Mirror {
        return Mirror(self, children: [:])
    }

    public var debugDescription: String {
        return value?.prettyDescription(0) ?? ""
    }
}

extension XML {
    public static var null: XML {
        return XML()
    }
}



