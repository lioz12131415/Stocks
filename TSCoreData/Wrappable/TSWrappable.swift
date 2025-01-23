//
//  TSWrappable.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 10/12/2024.
//

import CoreData
import Foundation

public protocol TSWrappable: TSPerform {
   
}

extension TSWrappable {
    public var ts: TSWrapper<Self> {
        return TSWrapper<Self>(self)
    }
}


