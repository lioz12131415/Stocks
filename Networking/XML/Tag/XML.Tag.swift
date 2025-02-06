//
//  XML.Tag.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension XML {
    public struct Tag {
        
        internal(set) public var key:   String
        internal(set) public var value: XMLValue?
        
        public var int: Int? {
            return string?.number()?.intValue
        }
        
        public var double: Double? {
            return string?.number()?.doubleValue
        }
        
        public var tags: [Tag]? {
            return value as? [Tag]
        }
        
        public var string: String? {
            return value as? String
        }
        
        public var number: NSNumber? {
            return string?.number()
        }
        
        public var tagsValue: [Tag] {
            return tags ?? []
        }
        
        public var stringValue: String {
            return string ?? ""
        }
        
        internal init(key: String, value: String) {
            self.key   = key
            self.value = value.xmlValue
        }
        
        internal func first(_ tag: String) -> Tag? {
            return tagsValue.first(where: { $0.key == tag })
        }
        
        internal func select(_ tag: String) -> [Tag]? {
            return tagsValue.filter { $0.key == tag }
        }
    }
}

extension XML.Tag {
    internal static var null: XML.Tag {
        return XML.Tag(key: "", value: "")
    }
}

extension XML.Tag {
    internal var absoluteTags: [Tag] {
        switch value {
            case let v as Tag:  return [v]
            case let v as Tags: return v
        default:
            return []
        }
    }
}
