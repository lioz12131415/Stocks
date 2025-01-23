//
//  String+Extensions.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension String {
    internal static var empty: String {
        return ""
    }
}

extension String {
    internal var convertToUrl: URL? {
        return URL(string: replacingOccurrences(of: " ", with: "%20"))
    }
}

extension String {
    internal func contains(_ value: String) -> Bool {
        return range(of: value) != nil
    }
}

extension String {
    internal func contains(scheme: String) -> Bool {
        guard contains(scheme) else {
            return false
        }
        return split(separator: ":")[0] == scheme
    }
}

extension String {
    internal static func prettyDescription(_ encodable: Encodable) -> String {
        guard let data   = try? JSONEncoder(.prettyPrinted).encode(encodable),
              let string = String(data: data, encoding: .utf8) else {
            return "nil"
        }
        return string
    }
}
