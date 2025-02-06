//
//  Keychain.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Security
import CryptoKit
import Foundation

final class Keychain {
    
    private(set) static var shared = Keychain()
    
    private init() {
        /* */
    }
    
    internal func symk(for identifier: String) -> SymmetricKey? {
        guard let sym = load(with: identifier) else {
            return save(symk: .init(size: .bits256), with: identifier)
        }
        return sym
    }
    
    internal func decrypt(_ data: Data, using symk: SymmetricKey) -> Data? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            return try AES.GCM.open(sealedBox, using: symk)
        } catch {
            print("Decryption failed: \(error)")
            return nil
        }
    }
    
    internal func encrypt(_ data: Data, using symk: SymmetricKey) -> Data? {
        do {
            let sealedBox = try AES.GCM.seal(data, using: symk)
            return sealedBox.combined
        } catch {
            print("Encryption failed: \(error)")
            return nil
        }
    }
}

extension Keychain {
    fileprivate func load(with identifier: String) -> SymmetricKey? {
        var query: [CFString: Any] = [
            kSecAttrAccount: identifier,
        ]
        query[kSecClass]      = kSecClassGenericPassword
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecReturnData] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        guard status == noErr,
              status != errSecItemNotFound else {
            return nil
        }
        guard let data = result as? Data else {
            return nil
        }
        return SymmetricKey(data: data)
    }
}

extension Keychain {
    fileprivate func save(symk: SymmetricKey, with account: String) -> SymmetricKey {
        let data = symk.withUnsafeBytes {
            Data($0)
        }
        var query: [CFString: Any] = [
            kSecValueData:   data,
            kSecAttrAccount: account,
        ]
        query[kSecClass]          = kSecClassGenericPassword
        query[kSecAttrAccessible] = kSecAttrAccessibleAfterFirstUnlock
        SecItemAdd(query as CFDictionary, nil)
        return symk
    }
}
