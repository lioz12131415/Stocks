//
//  NSSecureCoding+Extensions.swift
//  TSCoreData
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

extension NSSecureCoding {
    internal func data(_ secure: Bool = true) -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: secure)
    }
}

extension NSSecureCoding where Self: NSObject {
    internal static func object(from data: Data) -> Any? {
        guard let unarchiver = try? NSKeyedUnarchiver(forReadingFrom: data, secure: false) else {
            return nil
        }
        return unarchiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey)
    }
}

extension NSSecureCoding where Self: NSObject {
    internal func reflection(into object: NSManagedObject, for key: String) {
        guard let newValue = reflection() else {
            return
        }
        object.setValue(newValue, forKey: key)
    }
}

extension NSSecureCoding where Self: NSObject {
    internal func reflection() -> Self? {
        guard let data     = data(),
              let newValue = type(of: self).object(from: data) as? Self else {
            return nil
        }
        return SecureCopy.copy(self, into: newValue)
    }
}
