//
//  NSObject+Extentions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension NSObject {
    internal var pointer: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }
}

