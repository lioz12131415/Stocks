//
//  Deque+Iterator.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Deque {
    public struct Iterator: IteratorProtocol {
        
        private var backIterator:  Array<Element>.Iterator
        private var frontIterator: ReversedCollection<[Element]>.Iterator
        

        internal init(front: [Element], back: [Element]) {
            self.backIterator  = back.makeIterator()
            self.frontIterator = front.reversed().makeIterator()
        }
        
        public mutating func next() -> Element? {
            if let next = frontIterator.next() {
                return next
            }
            return backIterator.next()
        }
    }
}
