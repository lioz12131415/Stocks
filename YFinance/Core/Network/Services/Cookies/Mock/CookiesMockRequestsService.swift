//
//  CookiesMockRequestsService.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

class CookiesMockRequestsService: CookiesRequestsService {
    
    internal override func get() async throws -> HTTPCookie {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
}

