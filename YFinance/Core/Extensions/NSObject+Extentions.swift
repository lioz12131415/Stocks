//
//  NSObject+Extentions.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension NSObject {
    internal var pointer: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }
}

extension NSObject {
    internal func map(to key: inout UInt8) -> NSMutableDictionary {
        return withUnsafePointer(to: &key) { [weak self] in
            guard let self else {
                return NSMutableDictionary()
            }
            if let objc = objc_getAssociatedObject(self, $0) {
                return objc as! NSMutableDictionary
            }
            else {
                objc_setAssociatedObject(self, $0, NSMutableDictionary(), .OBJC_ASSOCIATION_RETAIN)
            }
            return objc_getAssociatedObject(self, $0) as! NSMutableDictionary
        }
    }
}
