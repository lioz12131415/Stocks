//
//  SecureArray.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

open class SecureArray<Element: Codable>: NSObject, SecurableObject {
    
    public typealias Iterator = Elements.Iterator
    public typealias Elements = ContiguousArray<Element>
    
    fileprivate var key: String
    fileprivate var scc: SecureCollectionChange
    fileprivate var obs: Observers<SecureCollectionObserve>
    
    internal var wrp: Wrapper<Elements> {
        didSet { scc.update(wrp.count, obs) }
    }
    
    public var count: Int {
        return wrp.count
    }
    
    public var isEmpty: Bool {
        return wrp.isEmpty
    }
    
    public var last: Element? {
        return wrp.last
    }
    
    public var first: Element? {
        return wrp.first
    }
    
    public override var description: String {
        return wrp.sync { $0.description }
    }
    
    public override var debugDescription: String {
        return wrp.sync { $0.debugDescription }
    }
    
    public subscript(index: Int) -> Element {
        get { wrp[index] }
        set { wrp[index] = newValue }
    }
    
    public init(_ key: String) {
        self.key = key
        self.obs = .init()
        self.wrp = .init(key)
        self.scc = .init(wrp.count)
    }
        
    public func save() {
        self.wrp.save()
        self.obs.saved()
    }
    
    public func removeAll() {
        self.wrp.sync { $0.removeAll() }
    }
    
    public func remove(at index: Int) {
        self.wrp.sync { $0.remove(at: index) }
    }
    
    public func push(_ newElement: Element) {
        self.wrp.sync { $0.push(newElement) }
    }
    
    public func append(_ newElement: Element) {
        self.wrp.sync { $0.append(newElement) }
    }
    
    public func insert(_ newElement: Element, at i: Int) {
        self.wrp.sync { $0.insert(newElement, at: i) }
    }
    
    public func remove(_ element: Element) where Element: Equatable {
        self.wrp.sync { $0.remove(element) }
    }
    
    public func contains(_ element: Element) -> Bool where Element: Equatable {
        self.wrp.sync { $0.contains(element) }
    }
    
    public func observe(_ observer: NSObject) -> any SecurableCollectionObserve {
        return obs.update(observe(for: observer))
    }
}

extension SecureArray: RandomAccessCollection, Sequence, Collection {
    public var endIndex: Int {
        return count
    }
    
    public var startIndex: Int {
        return .zero
    }
    
    public func makeIterator() -> Iterator {
        return wrp.sync { $0.makeIterator() }
    }
}

extension SecureArray: CustomReflectable {
    public var customMirror: Mirror {
        return Mirror(self, children: [:])
    }
}
