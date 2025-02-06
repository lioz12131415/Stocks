//
//  XMLValue+Tag.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension XML.Tag: XMLValue {
    public var asXML: XML {
        return XML(self)
    }
    
    public var asTag: Tag {
        return self
    }
    
    public var asTags: Tags {
        return absoluteTags
    }
    
    public var asInt: Int? {
        return int
    }
    
    public var asDouble: Double? {
        return double
    }
    
    public var asString: String? {
        return string
    }
    
    public var asNumber: NSNumber? {
        return number
    }
    
    public func first(_ tag: String) -> XML.Tag {
        return tagsValue.first(tag)
    }
    
    public func select(_ tag: String) -> [XML.Tag] {
        return tagsValue.select(tag)
    }
    
    public func prettyDescription(_ i: Int) -> String {
        let indent = String(repeating: "  ", count: i)
        var string = ""
        
        string += "\(indent)<\(key)>\n"
        string += "\(value?.prettyDescription(i + 1) ?? "")"
        string += "\(indent)</\(key)>\n"
        
        return string
    }
}
