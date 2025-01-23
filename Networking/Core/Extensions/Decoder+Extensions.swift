//
//  Decoder+Extensions.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Decoder {
    internal var jsonObjectValue: JSONObject? {
        let container = try? singleValueContainer()
        return container?.jsonObjectValue
    }
}
