//
//  Data+Extensions.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Data {
    internal var jsonObjectValue: JSONObject? {
        let decoder = try? HTTPDecoder.decode(self)
        return decoder?.jsonObjectValue
    }
}
