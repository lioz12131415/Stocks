//
//  OrderedSet+Codable.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension OrderedSet: Encodable where Element: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_table,    forKey: ._table)
        try container.encode(_elements, forKey: ._elements)
    }
}

extension OrderedSet: Decodable where Element: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._table    = try container.decode(Set<Int>.self,                 forKey: ._table)
        self._elements = try container.decode(ContiguousArray<Element>.self, forKey: ._elements)
    }
}

extension OrderedSet {
    internal enum CodingKeys: CodingKey {
        case _table
        case _elements
    }
}

