//
//  Decodable+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Decodable {
    internal static func load(key: String) -> Self? {
        guard let data = FileManager.default.read(from: key) else {
            return nil
        }
        return decrypt(from: data, with: key)
    }
}

extension Decodable {
    internal mutating func decrypt(from data: Data, with key: String) {
        guard let symk    = Keychain.shared.symk(for: key),
              let decrypt = Keychain.shared.decrypt(data, using: symk),
              let decoded = try? JSONDecoder().decode(Self.self, from: decrypt) else {
            return
        }
        self = decoded
    }
}

extension Decodable {
    internal static func decrypt(from data: Data, with key: String) -> Self? {
        guard let symk    = Keychain.shared.symk(for: key),
              let decrypt = Keychain.shared.decrypt(data, using: symk),
              let decoded = try? JSONDecoder().decode(Self.self, from: decrypt) else {
            return nil
        }
        return decoded
    }
}



