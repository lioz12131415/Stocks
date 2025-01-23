//
//  Array+Extensions.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Array where Element == JSON {
    internal subscript(safe index: Int) -> Element {
        set { if index >= 0 && index < count { self[index] = newValue } }
        get { if index >= 0 && index < count { self[index] } else { .null } }
    }
}
