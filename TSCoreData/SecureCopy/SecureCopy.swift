//
//  SecureCopy.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 16/01/2025.
//

import Foundation

final class SecureCopy {
    
    typealias TypeContainer = SecureCopyTypeContainer
    
    @discardableResult
    internal static func copy<T>(_ objc0: Any, into objc1: T) -> T? {
        guard Mirror.isClass(objc0) || Mirror.isStruct(objc0) else {
            return nil
        }
        let type  = type(of: objc0)
        let count = swift_reflectionMirror_recursiveCount(type)
        loop(type: type, count: count, objc0: objc0, objc1: objc1)
        return objc1
    }
}

extension SecureCopy {
    fileprivate static func loop(type t: Any.Type, count c: Int, objc0: Any?, objc1: Any) {
        for i in 0..<c {
            var metadata   = SecureCopyMetadata()
            let reflection = swift_reflectionMirror_recursiveChildMetadata(t,
                                                                           index: i,
                                                                           fieldMetadata: &metadata)
            defer {
                metadata.freeFunc?(metadata.name)
            }
            var this   = objc0
            var other  = objc1
            let offset = swift_reflectionMirror_recursiveChildOffset(t, index: i)
            
            let this_pointer = withUnsafePointer(to: &this) {
                return $0.withMemoryRebound(to: UnsafeMutableRawPointer.self, capacity: 1) {
                    return $0.pointee
                }
            }
            
            let other_pointer = withUnsafePointer(to: &other) {
                return $0.withMemoryRebound(to: UnsafeMutableRawPointer.self, capacity: 1) {
                    return $0.pointee
                }
            }
            
            let this_advanced  = this_pointer.advanced(by:  offset)
            let other_advanced = other_pointer.advanced(by: offset)
            
            let type_container    = TypeContainer(type: reflection)
            let accessors_pointee = type_container.accessors.pointee(this_advanced)
            type_container.accessors.set(accessors_pointee, in: other_advanced)
        }
    }
}
