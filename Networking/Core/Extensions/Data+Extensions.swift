//
//  Data+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 24/12/2024.
//

import Foundation

extension Data {
    internal var xmlValue: XMLValue? {
        guard let xml = String(data: self, encoding: .utf8) else {
            return nil
        }
        return xml.xmlValue
    }
}

extension Data {
    internal var jsonObjectValue: JSONObject? {
        let decoder = try? HTTPDecoder.decode(self)
        return decoder?.jsonObjectValue
    }
}

extension Data {
    internal var xmlMatches: [NSTextCheckingResult] {
        guard let xml = String(data: self, encoding: .utf8) else {
            return []
        }
        return xml.xmlMatches
    }
}
