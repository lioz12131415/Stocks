//
//  Sequence+Extensions.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Sequence {
    internal func joined<T: StringProtocol>(by separator: String = "", transform: (Element) -> T) -> String {
        reduce(into: "") { result, element in
            if !result.isEmpty {
                result += separator
            }
            result += transform(element)
        }
    }
}
