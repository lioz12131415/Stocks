//
//  NSFetchRequest+Extensions.swift
//  TSCoreData
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

extension NSFetchRequest {
    @objc convenience init(entityName: String, sorts: [NSSortDescriptor]) {
        self.init(entityName: entityName)
        self.sortDescriptors = sorts
    }
}
