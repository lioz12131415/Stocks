//
//  String+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
//

import Foundation

extension String {
    internal var xmlValue: XMLValue? {
        switch xmlMatches {
            case let m where m.count == 0:
                return self
            case let m where m.count == 1:
                return m[0].tagValue(self)
            case let m where m.count > 1:
                return m.compactMap { $0.tagValue(self) }
        default:
            return nil
        }
    }
}

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

extension String {
    internal func number(_ style: NumberFormatter.Style = .decimal) -> NSNumber? {
        let formatter = NumberFormatter(style)
        return formatter.number(from: self)
    }
}

extension String {
    internal var xmlMatches: [NSTextCheckingResult] {
        guard let regex = try? NSRegularExpression(pattern: "<(\\w+)(?:\\s+[^>]+)?>(.*?)</\\1>",
                                                   options: .dotMatchesLineSeparators) else {
            return []
        }
        let range   = NSRange(startIndex..<endIndex, in: self)
        let matches = regex.matches(in: self, options: [], range: range)
        return matches
    }
}

