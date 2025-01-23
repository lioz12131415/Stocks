//
//  AccessibleStorage+Associated.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

fileprivate var initialKey: UInt8 = 0

extension AccessibleStorage {
    internal func observer(for target: NSObject) -> Observer {
        let key      = target.pointer+pointer
        let observes = target.observes()
        if let observe = observes[key] as? Observer {
            return observe
        }
        else {
            observes[key] = Observer()
        }
        return observes[key] as! Observer
    }
}

extension NSObject {
    fileprivate func observes() -> NSMutableDictionary {
        return withUnsafePointer(to: &initialKey) { [weak self] in
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
