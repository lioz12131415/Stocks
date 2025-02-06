//
//  XMLValue+Array.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Array: XMLValue where Element == XML.Tag {
    public var asXML: XML {
        return XML(self)
    }
    
    public var asTag: Tag {
        return .null
    }
    
    public var asTags: Tags {
        return self
    }
    
    public var asInt: Int? {
        return nil
    }
    
    public var asDouble: Double? {
        return nil
    }
    
    public var asString: String? {
        return nil
    }
    
    public var asNumber: NSNumber? {
        return nil
    }
        
    public func first(_ tag: String) -> XML.Tag {
        return first(where: { $0.key == tag }) ?? .null
    }
    
    public func select(_ tag: String) -> [XML.Tag] {
        return filter { $0.key == tag }
    }
    
    public func prettyDescription(_ i: Int) -> String {
        return map { $0.prettyDescription(i) }.joined()
    }
}

