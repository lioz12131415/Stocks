//
//  OrderedMap+Codable.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension OrderedMap: Encodable where Key: Encodable, Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(keys, forKey: .keys)
        try container.encode(map,  forKey: .map)
    }
}

extension OrderedMap: Decodable where Key: Decodable, Value: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.map      = try container.decode(Map.self,  forKey: .map)
        self.keys     = try container.decode(Keys.self, forKey: .keys)
    }
}

extension OrderedMap {
    internal enum CodingKeys: CodingKey {
        case map
        case keys
    }
}
