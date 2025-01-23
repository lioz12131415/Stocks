//
//  Array+Extensions.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Array {
    internal subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else {
            return nil
        }
        return self[index]
    }
}

extension Array {
    internal mutating func removeAll(back: inout Array<Element>) {
        self.removeAll()
        back.removeAll()
    }
}

extension Array {
    internal mutating func removeLast(back: inout Array<Element>) -> Element? {
        if back.isEmpty {
            back = reversedRemove()
        }
        return back.popLast()
    }
}

extension Array {
    internal mutating func removeFirst(back: inout Array<Element>) -> Element? {
        if isEmpty {
            self = back.reversedRemove()
        }
        return self.popLast()
    }
}

extension Array {
    internal mutating func reversedRemove() -> Array<Element> {
        defer {
            removeAll()
        }
        return reversed()
    }
}

extension Array {
    internal func get(at index: Int, back: Array<Element>) -> Element? {
        guard index >= 0 && index < back.count+count else {
            return nil
        }
        guard index < count else {
            return back[index - count]
        }
        return self[count - index - 1]
    }
}

extension Array {
    internal mutating func insert(_ element: Element, at index: Int, back: inout Array<Element>) {
        guard index < count else {
            return back.insert(element, at: index - count)
        }
        insert(element, at: count - index)
    }
}

extension Array {
    internal mutating func remove(at index: Int, back: inout Array<Element>) -> Element? {
        guard index >= 0 && index < back.count+count else {
            return nil
        }
        guard index < count else {
            return back.remove(at: index - count)
        }
        return remove(at: count - index - 1)
    }
}

extension Array {
    internal mutating func update(_ element: Element?, at index: Int, back: inout Array<Element>) {
        guard let element = element, index >= 0 && index < back.count+count else {
            return
        }
        if index < count {
            self[count - index - 1] = element
        } else {
            back[index - count] = element
        }
    }
}
