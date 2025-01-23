//
//  NSObject+Extentions.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension NSObject {
    internal var pointer: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }
}
