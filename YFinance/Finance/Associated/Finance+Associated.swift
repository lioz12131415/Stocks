//
//  Finance+Associated.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

fileprivate var initialKey: UInt8 = 0

extension NSObject {
    public var finance: Finance {
        return withUnsafePointer(to: &initialKey) { [weak self] in
            guard let self else {
                return Finance()
            }
            if let objc = objc_getAssociatedObject(self, $0) {
                return objc as! Finance
            }
            else {
                objc_setAssociatedObject(self, $0, Finance(self), .OBJC_ASSOCIATION_RETAIN)
            }
            return objc_getAssociatedObject(self, $0) as! Finance
        }
    }
}
