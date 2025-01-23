//
//  TSPerform.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 10/12/2024.
//

import CoreData
import Foundation

public protocol TSPerform: NSManagedObject {
    static var context: NSManagedObjectContext { get }
}

extension TSPerform {
    @discardableResult
    internal func sync<V>(_ block: () -> V) -> V {
        var value: V!
        Self.context.performAndWait {
            value = block()
        }
        return value
    }
    
    @discardableResult
    internal func sync<V>(_ block: (Self) -> V) -> V {
        var value: V!
        Self.context.performAndWait {
            value = block(self)
        }
        return value
    }
    
    @discardableResult
    internal static func sync<V>(_ block: () -> V) -> V {
        var value: V!
        Self.context.performAndWait {
            value = block()
        }
        return value
    }
}

extension TSPerform {
    internal func async(_ block: @escaping() -> Void) {
        Self.context.perform {
            block()
        }
    }
    
    internal func async(_ block: @escaping(Self?) -> Void) {
        Self.context.perform { [weak self] in
            block(self)
        }
    }
    
    internal static func async(_ block: @escaping() -> Void) {
        Self.context.perform {
            block()
        }
    }
}


