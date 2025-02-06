//
//  Array+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 04/01/2025.
//

import Foundation

extension Array where Element == JSON {
    internal subscript(safe index: Int) -> Element {
        set { if index >= 0 && index < count { self[index] = newValue } }
        get { if index >= 0 && index < count { self[index] } else { .null } }
    }
}
