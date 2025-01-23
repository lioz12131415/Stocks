//
//  UIFont+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UIFont {
    internal static func bold(_ size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .bold)
    }
}

extension UIFont {
    internal static func semibold(_ size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .semibold)
    }
}
