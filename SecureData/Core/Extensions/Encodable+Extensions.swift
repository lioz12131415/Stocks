//
//  Encodable+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Encodable {
    internal func encrypt(with key: String) -> Data? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        guard let symk    = Keychain.shared.symk(for: key),
              let encrypt = Keychain.shared.encrypt(data, using: symk) else {
            return nil
        }
        return encrypt
    }
}
