//
//  Date+Extensions.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Date {
    internal var isExpired: Bool {
        return Date() >= self
    }
}
