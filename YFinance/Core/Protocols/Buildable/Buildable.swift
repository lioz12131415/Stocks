//
//  Buildable.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public protocol Buildable {
    init()
}

extension Buildable {
    public var builder: Builder<Self> {
        return Builder(self)
    }
}

public class Builder<B: Buildable> {
    
    fileprivate var buildable: B
    
    internal init(_ buildable: B = .init()) {
        self.buildable = buildable
    }
        
    @discardableResult public func build() -> B {
        return buildable
    }
    
    @discardableResult public func build(into other: inout B) -> B {
        other = buildable
        return other
    }
    
    @discardableResult public func set<V>(_ value: V, for keyPath: WritableKeyPath<B, V>) -> Self {
        buildable[keyPath: keyPath] = value
        return self
    }
}

