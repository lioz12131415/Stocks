//
//  NSObject+Extentions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension NSObject {
    internal var className: String {
        return String(describing: type(of: self))
    }
}

extension NSObject {
    internal class var className: String {
        return String(describing: self)
    }
}

extension NSObject {
    internal var pointer: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }
}



