//
//  NSDictionary+Extensions.swift
//  TSCoreData
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

extension NSDictionary {
    internal func reflection(into object: NSManagedObject, for key: String) {
        let reflection = mutableCopy() as? NSMutableDictionary
        for (key, value) in self {
            guard let oldvalue = value as? NSObject & NSSecureCoding,
                  let newValue = oldvalue.reflection() else {
                continue
            }
            guard let key = key as? NSCopying else {
                continue
            }
            reflection?.setObject(newValue, forKey: key)
        }
        object.setValue(reflection, forKey: key)
    }
}
