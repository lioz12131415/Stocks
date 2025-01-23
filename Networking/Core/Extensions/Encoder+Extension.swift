//
//  Encoder+Extension.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
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
