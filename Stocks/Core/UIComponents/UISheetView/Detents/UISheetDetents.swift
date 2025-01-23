//
//  UISheetDetents.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

struct UISheetDetents {
    
    typealias Element  = UISheetDetent
    typealias Elements = [Element]
    
    fileprivate var velocity: CGFloat
    fileprivate var elements: Elements
    
    private(set) weak var small:   Element?
    private(set) weak var large:   Element?
    private(set) weak var medium:  Element?
    private(set) weak var current: Element?
    
    internal var largest: Element {
        return elements.largest()
    }
    
    internal var smallest: Element {
        return elements.smallest()
    }
    
    internal init(_ elements: [UISheetDetent], threshold velocity: CGFloat = 500) {
        self.large    = elements.first(where: { $0.type == .large  })
        self.small    = elements.first(where: { $0.type == .small  })
        self.medium   = elements.first(where: { $0.type == .medium })
        self.current  = elements.smallest()
        self.velocity = velocity
        self.elements = elements
    }
        
    internal mutating func update(current: Element) {
        self.current = current
    }
    
    internal func get(_ type: Element.`Type`) -> Element? {
        self.elements.first(where: { $0.type == type })
    }
    
    internal mutating func update(current: Element.`Type`) {
        self.current = elements.first(where: { $0.type == current })!
    }
    
    internal func contains(_ type: Element.`Type`) -> Bool {
        self.elements.contains(where: { $0.type == type })
    }
    
    internal func reversed() -> ReversedCollection<[Element]> {
        self.elements.reversed()
    }
        
    internal mutating func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) {
        try? self.elements.sort(by: areInIncreasingOrder)
    }
}

extension UISheetDetents {
    @discardableResult
    internal func set(small point: CGFloat) -> Self {
        small?.update(point: point)
        return self
    }
    
    @discardableResult
    internal func set(large point: CGFloat) -> Self {
        large?.update(point: point)
        return self
    }
    
    @discardableResult
    internal func set(medium point: CGFloat) -> Self {
        medium?.update(point: point)
        return self
    }
}

extension UISheetDetents {
    internal func nearest(to point: CGFloat) -> Element? {
        guard let element = elements.min(by: { abs($0.point-point) < abs($1.point-point) }) else {
            return small
        }
        return element
    }
    
    internal func nearest(to point: CGFloat, velocity v: CGFloat) -> Element? {
        guard abs(v) > velocity else {
            return nearest(to: point)
        }
        guard v < 0 else {
            return reversed().first (where: { $0.point > point }) ?? nearest(to: point)
        }
        return elements.first (where: { $0.point < point }) ?? nearest(to: point)
    }
}

extension Array where Element: UISheetDetent {
    internal func smallest() -> Element {
        if let small = first(where: { $0.type == .small }) {
            return small
        }
        if let medium = first(where: { $0.type == .medium }) {
            return medium
        }
        if let large = first(where: { $0.type == .large }) {
            return large
        }
        fatalError("Error")
    }
}

extension Array where Element: UISheetDetent {
    internal func largest() -> Element {
        if let large = first(where: { $0.type == .large }) {
            return large
        }
        if let medium = first(where: { $0.type == .medium }) {
            return medium
        }
        if let small = first(where: { $0.type == .small }) {
            return small
        }
        fatalError("Error")
    }
}
