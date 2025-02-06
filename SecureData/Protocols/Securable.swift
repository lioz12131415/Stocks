//
//  Securable.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Structures
import Foundation

public protocol Securable where Self: Codable {
    init()
}

extension ContiguousArray: Securable where Element: Codable { }
extension OrderedMap: Securable where Key: Codable, Value: Codable { }
