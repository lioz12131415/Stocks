//
//  SecureCopy+SilgenNames.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 16/01/2025.
//

import Foundation

@_silgen_name("swift_reflectionMirror_recursiveCount")
internal func swift_reflectionMirror_recursiveCount(_: Any.Type) -> Int

@_silgen_name("swift_reflectionMirror_recursiveChildMetadata")
internal func swift_reflectionMirror_recursiveChildMetadata(
    _: Any.Type
    , index: Int
    , fieldMetadata: UnsafeMutablePointer<SecureCopyMetadata>
) -> Any.Type

@_silgen_name("swift_reflectionMirror_recursiveChildOffset")
internal func swift_reflectionMirror_recursiveChildOffset(_: Any.Type, index: Int) -> Int
