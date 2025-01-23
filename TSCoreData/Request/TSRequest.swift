//
//  TSRequest.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 10/12/2024.
//

import CoreData
import Foundation

final public class TSRequest<O: TSFetch> {
    
    public typealias Sort      = NSSortDescriptor
    public typealias Context   = NSManagedObjectContext
    public typealias Predicate = NSPredicate
    
    fileprivate var limit:  Int? = nil
    fileprivate var offset: Int? = nil
    
    fileprivate var sorts:      [Sort]      = []
    fileprivate var predicates: [Predicate] = []
    
    fileprivate var name: String {
        return O.name
    }
    
    fileprivate var context: Context {
        return O.context
    }
    
    fileprivate var request: NSFetchRequest<O> {
        return NSFetchRequest<O>(entityName: name)
    }
        
    public var last: O? {
        return all.last
    }

    public var all: [O] {
        return get()
    }
    
    public var first: O? {
        return all.first
    }

    public var count: Int {
        return O.sync {
            context.count(request)
        }
    }
    
    @discardableResult
    public func sort(_ sort: Sort) -> Self {
        sorts.append(sort)
        return self
    }
    
    @discardableResult
    internal func limit(_ value: Int) -> Self {
        limit = value
        return self
    }
    
    @discardableResult
    internal func offset(_ value: Int) -> Self {
        offset = value
        return self
    }
        
    @discardableResult
    public func predicate(_ predicate: Predicate) -> Self {
        predicates.append(predicate)
        return self
    }
    
    public func get(_ type: NSCompoundPredicate.LogicalType = .and) -> Array<O> {
        let request = NSFetchRequest<O>(entityName: name, sorts: sorts)
        
        if let limit  = limit  { request.fetchLimit  = limit  }
        if let offset = offset { request.fetchOffset = offset }
        
        if predicates.count > .zero {
            request.predicate = NSCompoundPredicate(type: type, subpredicates: predicates)
        }

        return O.sync {
            context.fetch(request: request)
        }
    }
}

