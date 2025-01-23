//
//  String+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension String {
    internal static var empty: String {
        return ""
    }
}

extension String {
    internal var nsstringValue: NSString {
        return self as NSString
    }
}

extension String {
    internal func contains(_ value: String) -> Bool {
        return range(of: value) != nil
    }
}

extension String {
    internal var convertToUrl: URL? {
        return URL(string: replacingOccurrences(of: " ", with: "%20"))
    }
}

extension String {
    internal func size(_ font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [.font: font])
    }
}

extension String {
    internal func width(_ font: UIFont) -> CGFloat {
        return size(font).width
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
