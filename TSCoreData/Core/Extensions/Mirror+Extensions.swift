//
//  Mirror+Extensions.swift
//  TSCoreData
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Mirror {
    internal static func isClass(_ objc: Any) -> Bool {
        guard let displayStyle = Mirror(reflecting: objc).displayStyle else {
            return false
        }
        return displayStyle == .class
    }
}

extension Mirror {
    internal static func isStruct(_ objc: Any) -> Bool {
        guard let displayStyle = Mirror(reflecting: objc).displayStyle else {
            return false
        }
        return displayStyle == .struct
    }
}
