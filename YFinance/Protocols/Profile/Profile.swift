//
//  Profile.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public protocol Profile: Ticker {
    var symbol:    String { get }
    var exchange:  String { get }
    var quoteType: String { get }
    var shortName: String { get }
}

extension Array where Element: Profile {
    public var symbols: [String] {
        return map(\.symbol)
    }
}
