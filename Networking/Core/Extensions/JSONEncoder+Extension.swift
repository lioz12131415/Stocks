//
//  JSONEncoder+Extension.swift
//  Networking
//
//  Created by ליעוז בלקי on 22/12/2024.
//

import Foundation

extension JSONEncoder {
    internal convenience init(_ formatting: OutputFormatting) {
        self.init()
        self.outputFormatting = formatting
    }
}
