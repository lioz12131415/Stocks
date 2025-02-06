//
//  NumberFormatter+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension NumberFormatter {
    internal convenience init(_ style: NumberFormatter.Style) {
        self.init()
        self.numberStyle = style
    }
}
