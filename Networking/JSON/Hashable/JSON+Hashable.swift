//
//  JSON+Hashable.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension JSON: Hashable {
    public static func ==(lhs: JSON, rhs: JSON) -> Bool {
        guard let lhs = lhs.object,
              let rhs = rhs.object else {
            return false
        }
        return lhs.isEqual(to: rhs)
    }
}
