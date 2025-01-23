//
//  NSKeyedUnarchiver+Extensions.swift
//  TSCoreData
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension NSKeyedUnarchiver {
    internal convenience init(forReadingFrom data: Data, secure: Bool) throws {
        try self.init(forReadingFrom: data)
        self.requiresSecureCoding = secure
    }
}
