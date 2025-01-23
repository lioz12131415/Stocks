//
//  TSManagedObject.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 10/12/2024.
//

import CoreData
import Foundation

public protocol TSManagedObject: NSManagedObject, TSWrappable, TSPerform, TSFetch {
    static var context: NSManagedObjectContext { get }
}

extension TSManagedObject {
    public static var new: Self {
        return sync { Self(context: context) }
    }
    
    public static func save(_ type: TSSave<Self>) {
        type.execute()
    }
}



