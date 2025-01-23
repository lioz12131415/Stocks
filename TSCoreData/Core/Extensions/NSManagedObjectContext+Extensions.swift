//
//  NSManagedObjectContext+Extensions.swift
//  TSCoreData
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

typealias ObjectsSet   = Set<NSManagedObject>
typealias SecureObject = NSObject & NSSecureCoding

extension NSManagedObjectContext {
    internal func count<O: NSManagedObject>(_ request: NSFetchRequest<O>) -> Int {
        return (try? count(for: request)) ?? .zero
    }
    
    internal func fetch<R: NSFetchRequestResult>(request: NSFetchRequest<R>) -> [R] {
        return (try? fetch(request)) ?? []
    }
}

extension NSManagedObject {
    public func cow() {
        for key in entity.attributesByName.keys {
            switch value(forKey: key) {
                case let value as ObjectsSet:   value.forEach { $0.cow() }
                case let value as NSDictionary: value.reflection(into: self, for: key)
                case let value as SecureObject: value.reflection(into: self, for: key)
            default:
                continue
            }
        }
    }
}
