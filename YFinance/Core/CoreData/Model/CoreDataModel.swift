//
//  CoreDataModel.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

final class CoreDataModel {
    
    internal var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
    internal func object(for resource: String) -> NSManagedObjectModel {
        guard let url   = bundle.url(forResource: resource, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("TODO - Handle error")
        }
        return model
    }
}

