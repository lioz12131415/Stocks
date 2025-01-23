//
//  CookiesRequestsService.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

class CookiesRequestsService: NetworkService<CookiesEndpoints> {
        
    internal func get() async throws -> HTTPCookie {
        let request  = request(.get)
        let session  = session(request)
        let response = try await get(session)
    
        return try await HTTPCookies.cookie(with: "Set-Cookie", for: response.1)
    }
}

extension CookiesRequestsService {
    internal static var mock: CookiesRequestsService {
        return CookiesMockRequestsService()
    }
}

extension CookiesRequestsService {
    internal static var `default`: CookiesRequestsService {
        return CookiesRequestsService()
    }
}

