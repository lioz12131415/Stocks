//
//  Data+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Data {
    internal var stringValue: String? {
        return String(data: self, encoding: .utf8)
    }
}

extension Data {
    internal func string() async throws -> String {
        guard let string = stringValue else {
            throw DecodingError.valueNotFound(Self.self,
                .init(codingPath: [], debugDescription: "")
            )
        }
        return string
    }
}

extension Data {
    internal init(file name: String) throws {
        guard let file = Bundle.main.url(forResource: name, withExtension: "json") else {
            fatalError("TODO throws Error")
        }
        try self.init(contentsOf: file)
    }
}
