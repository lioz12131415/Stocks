//
//  LinkedList+Collection.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension LinkedList: Collection {
    
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    public var startIndex: Index {
        return Index(node: head)
    }
    
    public subscript(position: Index) -> Node {
        return position.node!
    }
    
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
}

extension LinkedList {
    public struct Index: Comparable {
        
        internal var node: Node?
        
        public static func ==(lhs: Index, rhs: Index) -> Bool {
            if let left = lhs.node, let right = rhs.node {
                return left.next === right.next
            }
            return lhs.node == nil && rhs.node == nil
        }
        
        public static func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            return sequence(first: lhs.node) {
                $0?.next
            }.contains { $0 === rhs.node }
        }
    }
}

