//
//  SecureCopy+Metadata.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 16/01/2025.
//

import Foundation

typealias NameFreeFunc = @convention(c) (UnsafePointer<CChar>?) -> Void

struct SecureCopyMetadata {
    let name: UnsafePointer<CChar>? = nil
    let freeFunc: NameFreeFunc? = nil
    let isStrong: Bool = false
    let isVar: Bool = false
}
