//
//  OrderedSet+Collection.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension OrderedSet: Collection {
    public var endIndex: Int {
        _elements.endIndex
    }
    
    public var startIndex: Int {
        _elements.startIndex
    }
    
    public func index(after i: Int) -> Int {
        _elements.index(after: i)
    }
    
    public subscript(position: Int) -> Element {
        return _elements[position]
    }
}
