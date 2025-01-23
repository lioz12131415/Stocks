//
//  JSONEncoder+Extension.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension JSONEncoder {
    internal convenience init(_ formatting: OutputFormatting) {
        self.init()
        self.outputFormatting = formatting
    }
}
