//
//  HTTPCookies+Extensions.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension HTTPCookies {
    public static func cookie(with fields: [String : String], for url: URL?) async throws -> HTTPCookie {
        guard let url    = url,
              let cookie = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url).first else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        return cookie
    }
}

extension HTTPCookies {
    public static func cookie(with field: String, for response: HTTPURLResponse) async throws -> HTTPCookie {
        guard let url    = response.url,
              let header = response.allHeaderFields[field] as? String else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        return try await cookie(with: [field: header], for: url)
    }
}

