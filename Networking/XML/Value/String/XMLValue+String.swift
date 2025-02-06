//
//  XMLValue+String.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension String: XMLValue {
    public var asXML: XML {
        return .null
    }
    
    public var asTag: Tag {
        return .null
    }
    
    public var asTags: Tags {
        return []
    }
    
    public var asString: String? {
        return self
    }
    
    public var asInt: Int? {
        return asNumber?.intValue
    }
    public var asDouble: Double? {
        return asNumber?.doubleValue
    }
    
    public var asNumber: NSNumber? {
        return number(.decimal)
    }
    
    public func first(_ tag: String) -> XML.Tag {
        return .null
    }
    
    public func select(_ tag: String) -> [XML.Tag] {
        return []
    }
    
    public func prettyDescription(_ i: Int) -> String {
        return .init(repeating: "  ", count: i)+"\(self)\n"
    }
}
