//
//  Encoder+Extension.swift
//  Networking
//
//  Created by ליעוז בלקי on 22/12/2024.
//

import Foundation

extension Encoder {
    internal func encode(_ object: JSONObject?) throws {
        var container = singleValueContainer()
        guard let object = object else {
            return try container.encodeNil()
        }
        try container.encode(object)
    }
}
