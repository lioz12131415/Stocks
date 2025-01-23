//
//  HTTPCookie+Extensions.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension HTTPCookie {
    public func expiresDate() throws -> Date {
        guard let expiry = expiresDate else {
            throw NSError(domain: "HTTPCookie expiresDate is nil", code: -999)
        }
        return expiry
    }
}
