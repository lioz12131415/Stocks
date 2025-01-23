//
//  MapTable.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public class MapTable<Value: NSObject>: NSObject {
    
    fileprivate var storage: NSMapTable<NSString, Value> = {
        .init(keyOptions: .strongMemory, valueOptions: .weakMemory)
    }()
    
    public var count: Int {
        return storage.count
    }
    
    public var isEmpty: Bool {
        return count == .zero
    }
    
    public var keys: [String] {
        return storage.keys
    }
    
    public var values: [Value] {
        return storage.values as! [Value]
    }
    
    @discardableResult
    public func update(_ value: Value) -> Value {
        objc_sync_enter(storage); defer { objc_sync_exit(storage) }
        storage.setObject(value, forKey: value.pointer.nsstringValue)
        return value
    }
    
    @discardableResult
    public func remove(_ value: Value?) -> Value? {
        objc_sync_enter(storage); defer { objc_sync_exit(storage) }
        storage.removeObject(forKey: value?.pointer.nsstringValue)
        return value
    }
    
    public func get(for pointer: String) -> Value? {
        objc_sync_enter(storage); defer { objc_sync_exit(storage) }
        return storage.object(forKey: pointer.nsstringValue)
    }
}

extension MapTable: Sequence {
    public func makeIterator() -> IndexingIterator<[Value]> {
        return values.makeIterator()
    }
}
