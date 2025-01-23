//
//  Numberable.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public protocol Numberable: ExpressibleByIntegerLiteral, Comparable, Codable {
    static var zero: Self { get }
    
    init(_ number: NSNumber)
    init?(_ number: NSNumber?)
}

extension Int: Numberable {
    public init?(_ number: NSNumber?) {
        guard let number = number else {
            return nil
        }
        self = number.intValue
    }
}

extension Double: Numberable {
    public init?(_ number: NSNumber?) {
        guard let number = number else {
            return nil
        }
        self = number.doubleValue
    }
}
