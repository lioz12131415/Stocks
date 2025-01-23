//
//  SecureCopy+TypeContainer.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 16/01/2025.
//

import Foundation

struct SecureCopyTypeContainer {
    
    typealias Accessors = SecureCopyAccessors
    
    let type: Any.Type
    let witnessTable = 0
    /*
     * */
    init(type: Any.Type) {
        self.type = type
    }
    /*
     * */
    var accessors: Accessors.Type {
        unsafeBitCast(self, to: Accessors.Type.self)
    }
}
