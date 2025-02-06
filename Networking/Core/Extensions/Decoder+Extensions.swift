//
//  Decoder+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 24/12/2024.
//

import Foundation

extension Decoder {
    internal var jsonObjectValue: JSONObject? {
        let container = try? singleValueContainer()
        return container?.jsonObjectValue
    }
}
