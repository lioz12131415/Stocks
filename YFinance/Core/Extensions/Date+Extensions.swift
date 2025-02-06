//
//  Date+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Date {
    internal var isExpired: Bool {
        return Date() >= self
    }
}
