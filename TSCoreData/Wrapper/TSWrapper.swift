//
//  TSWrapper.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 10/12/2024.
//

import CoreData
import Foundation

@dynamicMemberLookup
public class TSWrapper<O: TSWrappable> {
    
    fileprivate var object: O
    
    fileprivate var context: NSManagedObjectContext {
        return O.context
    }
    
    internal init(_ object: O) {
        self.object = object
    }
    
    public subscript<V>(dynamicMember keyPath: KeyPath<O, V>) -> V {
        get { sync { object[keyPath: keyPath] } }
    }
    
    public subscript<V>(dynamicMember keyPath: KeyPath<O, V?>) -> V? {
        get { sync { object[keyPath: keyPath] } }
    }
    
    public subscript<V>(dynamicMember keyPath: WritableKeyPath<O, V>) -> V {
        get { sync { object[keyPath: keyPath] } }
        set { sync { object[keyPath: keyPath] = newValue } }
    }
    
    public subscript<V>(dynamicMember keyPath: WritableKeyPath<O, V?>) -> V? {
        get { sync { object[keyPath: keyPath] } }
        set { sync { object[keyPath: keyPath] = newValue } }
    }
    
    @discardableResult
    public func set<V>(_ value: V, for keyPath: WritableKeyPath<O, V>) -> Self {
        sync { object[keyPath: keyPath] = value }
        return self
    }
    
    fileprivate func sync<V>(_ block: () -> V) -> V {
        var value: V!
        context.performAndWait {
            value = block()
        }
        return value
    }
}
