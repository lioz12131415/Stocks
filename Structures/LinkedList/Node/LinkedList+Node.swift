//
//  LinkedList+Node.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension LinkedList {
    public class Node: Codable {
        
        internal weak var prev:    Node?
        internal /**/ var next:    Node?
        internal /**/ var element: Element
        
        internal init(next: Node? = nil, prev: Node? = nil, element: Element) {
            self.next    = next
            self.prev    = prev
            self.element = element
        }
        
        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.next     = try container.decode(Node?.self,   forKey: .next)
            self.element  = try container.decode(Element.self, forKey: .element)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(next,    forKey: .next)
            try container.encode(element, forKey: .element)
        }
        
        enum CodingKeys: CodingKey {
            case next
            case prev
            case element
        }
    }
}

extension LinkedList.Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(element)"
        }
        return "\(element) -> \(String(describing: next))"
    }
}
