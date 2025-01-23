//
//  LinkedList.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public class LinkedList<Element: Codable>: Codable, ExpressibleByArrayLiteral {
    
    internal var head: Node?
    internal var tail: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var arrayValue: [Element] {
        return map { $0.element }
    }
    
    public init(_ elements: [Element] = []) {
        elements.forEach { append($0) }
    }
    
    public required init(arrayLiteral elements: Element...) {
        elements.forEach { append($0) }
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let elements  = try container.decode([Element].self, forKey: .elements)
        self.init(elements)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(arrayValue, forKey: .elements)
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    @discardableResult public func pop() -> Node? {
        defer {
            head = head?.next
            head?.prev = nil
            tail = head == nil ? nil : tail
        }
        return head
    }
    
    @discardableResult public func removeLast() -> Node? {
        if tail === head {
            return pop()
        }
        defer {
            tail?.prev?.next = nil
            tail = tail?.prev
        }
        return tail
    }
    
    @discardableResult public func remove(_ node: Node) -> Node? {
        if node === head {
            return pop()
        }
        if node === tail {
            return removeLast()
        }
        let prev   = node.prev
        let next   = node.next
        node.prev  = nil
        node.next  = nil
        prev?.next = next
        next?.prev = prev
        return node
    }
    
    @discardableResult public func push(_ element: Element) -> Node {
        head = Node(next: head, element: element)
        tail = tail == nil ? head : tail
        head?.next?.prev = head
        return head!
    }
    
    @discardableResult public func append(_ element: Element) -> Node {
        guard !isEmpty else {
            return push(element)
        }
        tail?.next = Node(prev: tail, element: element)
        tail       = tail?.next
        return tail!
    }
    
    @discardableResult public func insert(_ element: Element, after node: Node) -> Node {
        if node === tail {
            return append(element)
        }
        let new = Node(next: node.next, prev: node, element: element)
        node.next?.prev = new
        node.next = new
        return node.next!
    }
    
    @discardableResult public func insert(_ element: Element, before node: Node) -> Node {
        if node === head {
            return push(element)
        }
        let new = Node(next: node, prev: node.prev, element: element)
        node.prev?.next = new
        node.prev = new
        return new
    }
    
    enum CodingKeys: CodingKey {
        case elements
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return ""
        }
        return String(describing: head)
    }
}
