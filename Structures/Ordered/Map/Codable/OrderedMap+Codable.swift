//
//  OrderedMap+Codable.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension OrderedMap: Encodable where Key: Encodable, Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_keys, forKey: ._keys)
        try container.encode(_dict, forKey: ._dict)
    }
}

extension OrderedMap: Decodable where Key: Decodable, Value: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._keys    = try container.decode(ContiguousArray<Key>.self,   forKey: ._keys)
        self._dict    = try container.decode(Dictionary<Key, Value>.self, forKey: ._dict)
    }
}

extension OrderedMap {
    internal enum CodingKeys: CodingKey {
        case _keys
        case _dict
    }
}
