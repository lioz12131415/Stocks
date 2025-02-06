//
//  XML+Collection.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension XML: RandomAccessCollection, Collection, Sequence {
    
    public typealias Index    = Int
    public typealias Indices  = Range<Int>
    public typealias Iterator = Array<XML>.Iterator
    
    fileprivate var arrayValue: Array<XML> {
        return value?.asTags.compactMap(\.asXML) ?? []
    }
    
    public var count: Int {
        return arrayValue.count
    }
    
    public func makeIterator() -> Array<XML>.Iterator {
        return arrayValue.makeIterator()
    }
    
    @inlinable
    public var startIndex: Int {
        return .zero
    }
    
    @inlinable
    public var endIndex: Int {
        return count
    }
    
    @inlinable
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    @inlinable
    public func formIndex(after i: inout Int) {
        i += 1
    }
    
    @inlinable
    public func index(before i: Int) -> Int {
        return i - 1
    }
    
    @inlinable
    public func formIndex(before i: inout Int) {
        i -= 1
    }
    
    @inlinable
    public func distance(from start: Int, to end: Int) -> Int {
        return end - start
    }
    
    @inlinable
    public func index(_ i: Int, offsetBy distance: Int) -> Int {
        return i + distance
    }
    
    @inlinable
    public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {
        let l = limit - i
        if distance > 0 ? l >= 0 && l < distance : l <= 0 && distance < l {
            return nil
        }
        return i + distance
    }
}

