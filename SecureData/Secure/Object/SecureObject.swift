//
//  SecureObject.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

@dynamicMemberLookup
open class SecureObject<Element: Securable>: NSObject, SecurableObject {
    
    fileprivate var wrp: Wrapper<Element>
    fileprivate var obs: Observers<SecureObserve>
    
    public var element: Element {
        return wrp.sync { $0 }
    }
    
    public init(_ key: String) {
        self.obs = .init()
        self.wrp = .init(key)
    }
    
    public func save() {
        self.wrp.save()
        self.obs.saved()
    }
    
    public subscript<V>(dynamicMember keyPath: KeyPath<Element, V>) -> V {
        get { wrp[dynamicMember: keyPath] }
    }
    
    public subscript<V>(dynamicMember keyPath: KeyPath<Element, V?>) -> V? {
        get { wrp[dynamicMember: keyPath] }
    }
    
    public subscript<V>(dynamicMember keyPath: WritableKeyPath<Element, V>) -> V {
        get { wrp[dynamicMember: keyPath] }
        set { wrp[dynamicMember: keyPath] = newValue; obs.updated() }
    }
    
    public subscript<V>(dynamicMember keyPath: WritableKeyPath<Element, V?>) -> V? {
        get { wrp[dynamicMember: keyPath] }
        set { wrp[dynamicMember: keyPath] = newValue; obs.updated() }
    }
    
    @discardableResult
    public func set<V>(_ value: V, for keyPath: WritableKeyPath<Element, V>) -> Self {
        self[dynamicMember: keyPath] = value
        return self
    }
}

