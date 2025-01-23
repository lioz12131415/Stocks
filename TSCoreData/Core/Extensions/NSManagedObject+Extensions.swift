//
//  NSManagedObject+Extensions.swift
//  TSCoreData
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

extension NSManagedObject {
    internal static var name: String {
        return String(describing: Self.self)
    }
}

