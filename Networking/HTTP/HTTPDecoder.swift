//
//  HTTPDecoder.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public struct HTTPDecoder: Decodable {
    
    internal var decoder: Decoder
    
    public init(from decoder: Decoder) {
        self.decoder = decoder
    }
    
    public static func decode(_ data: Data) throws -> Decoder {
        return try JSONDecoder().decode(HTTPDecoder.self, from: data).decoder
    }
    
    public static func decode<T: Decodable>(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    public static func decode<T: Decodable>(_ data: Data, type: T.Type) throws -> T {
        return try JSONDecoder().decode(type.self, from: data)
    }
}

