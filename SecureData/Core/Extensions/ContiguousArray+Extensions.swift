//
//  ContiguousArray+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension ContiguousArray {
    internal mutating func push(_ newElement: Element) {
        self.insert(newElement, at: .zero)
    }
}

extension ContiguousArray where Element: Equatable {
    internal mutating func remove(_ element: Element) {
        guard let index = firstIndex(of: element) else {
            return
        }
        self.remove(at: index)
    }
}
