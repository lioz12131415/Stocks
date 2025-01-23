//
//  OrderedSet.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public struct OrderedSet<Element: Hashable>: Equatable, Hashable {
    
    internal var _table    = Set<Int>()
    internal var _elements = ContiguousArray<Element>()
    
    public mutating func remove(at index: Int) {
        let element = _elements.remove(at: index)
        self._table.remove(element.hashValue)
    }
    
    public mutating func append(_ element: Element) {
        guard !_table.contains(element.hashValue) else {
            return
        }
        self._elements.append(element)
        self._table.insert(element.hashValue)
    }
    
    public mutating func update(_ element: Element) {
        guard contains(element) else {
            return append(element)
        }
        self.remove(element)
        self.append(element)
    }
    
    public mutating func remove(_ element: Element) {
        guard let index = _elements.firstIndex(of: element) else {
            return
        }
        self._elements.remove(at: index)
        self._table.remove(element.hashValue)
    }
    
    public mutating func insert(_ element: Element, at index: Int) {
        guard !_table.contains(element.hashValue) else {
            return
        }
        self._table.insert(element.hashValue)
        self._elements.insert(element, at: index)
    }
    
    public mutating func update(_ element: Element, at index: Int) {
        guard contains(element) else {
            return insert(element, at: index)
        }
        self.remove(element)
        self.insert(element, at: index)
    }
}

extension OrderedSet {
    public func contains(_ element: Element) -> Bool {
        return _table.contains(element.hashValue)
    }
}

extension OrderedSet: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self._table    = Set(elements.map { $0.hashValue })
        self._elements = ContiguousArray(elements)
    }
}

extension OrderedSet: CustomReflectable, CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return _elements.description
    }
    
    public var customMirror: Mirror {
        return Mirror(self, children: [:])
    }
    
    public var debugDescription: String {
        return _elements.debugDescription
    }
}
