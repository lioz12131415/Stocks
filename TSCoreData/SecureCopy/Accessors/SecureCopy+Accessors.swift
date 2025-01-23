//
//  SecureCopy+Accessors.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 16/01/2025.
//

import Foundation

protocol SecureCopyAccessors {
    /* * * * * */
}

extension SecureCopyAccessors {
    internal static func pointee(_ p: UnsafeMutableRawPointer) -> Any {
        return p.assumingMemoryBound(to: self).pointee
    }
}

extension SecureCopyAccessors {
    internal static func set(_ value: Any?, in pointer: UnsafeMutableRawPointer) {
        guard let pointee = value as? Self else {
            return
        }
        pointer.assumingMemoryBound(to: self).pointee = pointee
    }
}
