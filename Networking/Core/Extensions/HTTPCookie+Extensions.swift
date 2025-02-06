//
//  HTTPCookie+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 22/12/2024.
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
