//
//  NSCoder+Extensions.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension NSCoder {
    internal func decode<T: Codable, K: RawRepresentable>(for key: K) -> T? where K.RawValue == String {
        guard let data   = decodeObject(forKey: key.rawValue) as? Data,
              let object = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return object
    }
}

extension NSCoder {
    internal func encode<T: Codable, K: RawRepresentable>(_ object: T, for key: K) where K.RawValue == String {
        guard let data = try? JSONEncoder().encode(object) else {
            return
        }
        return encode(data, forKey: key.rawValue)
    }
}
