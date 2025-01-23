//
//  Deque.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public struct Deque<Element>: ExpressibleByArrayLiteral {
    
    internal var back:  [Element] = []
    internal var front: [Element] = []
    
    public var count: Int {
        return front.count + back.count
    }
    
    public var isEmpty: Bool {
        return count == 0
    }

    public init() {
        
    }
    
    public init(arrayLiteral elements: Element...) {
        back = Array(elements)
    }
    
    public init<S: Sequence>(_ elements: S) where S.Element == Element {
        back = Array(elements)
    }
    
    public subscript(index: Int) -> Element {
        get { front.get(at: index, back: back)! }
        set { front.update(newValue, at: index, back: &back) }
    }
    
    public subscript(safe index: Int) -> Element? {
        get { front.get(at: index, back: back) }
        set { front.update(newValue, at: index, back: &back) }
    }
    
    public mutating func removeAll() {
        return front.removeAll(back: &back)
    }
    
    public mutating func append(_ element: Element) {
        return back.append(element)
    }

    public mutating func prepend(_ element: Element) {
        return front.append(element)
    }
    
    public mutating func insert(_ element: Element, at index: Int) {
        return front.insert(element, at: index, back: &back)
    }
    
    @discardableResult public mutating func removeLast() -> Element? {
        return front.removeLast(back: &back)
    }
    
    @discardableResult public mutating func removeFirst() -> Element? {
        return front.removeFirst(back: &back)
    }
    
    @discardableResult public mutating func remove(at index: Int) -> Element? {
        return front.remove(at: index, back: &back)
    }
}

extension Deque: Sequence {
    public func makeIterator() -> Iterator {
        return Iterator(front: front, back: back)
    }
}

extension Deque: CustomReflectable, CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return map { $0 }.description
    }
    
    public var customMirror: Mirror {
        return Mirror(self, children: [:])
    }
    
    public var debugDescription: String {
        return map { $0 }.description
    }
}

