//
//  Deque+Codable.swift
//  Structures
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Deque: Encodable where Element: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(back,  forKey: .back)
        try container.encode(front, forKey: .front)
    }
}

extension Deque: Decodable where Element: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.back     = try container.decode([Element].self, forKey: .back)
        self.front    = try container.decode([Element].self, forKey: .front)
    }
}

extension Deque {
    internal enum CodingKeys: CodingKey {
        case back
        case front
    }
}
