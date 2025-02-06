//
//  XMLValue.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public protocol XMLValue {
    typealias Tag  = XML.Tag
    typealias Tags = Array<XML.Tag>
    
    var asXML:  XML  { get }
    var asTag:  Tag  { get }
    var asTags: Tags { get }
    
    var asInt:    Int?      { get }
    var asDouble: Double?   { get }
    var asString: String?   { get }
    var asNumber: NSNumber? { get }
    
    func first(_ tag: String) -> XML.Tag
    func select(_ tag: String) -> [XML.Tag]
    func prettyDescription(_ i: Int) -> String
}

