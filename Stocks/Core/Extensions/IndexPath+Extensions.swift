//
//  IndexPath+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension IndexPath {
    internal init(row: Int) {
        self.init(row: row, section: 0)
    }
}

extension IndexPath {
    internal static var zero: IndexPath {
        return .init(item: .zero, section: .zero)
    }
}

