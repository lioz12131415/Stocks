//
//  CrumbMockRequestsService.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

class CrumbMockRequestsService: CrumbRequestsService {
    
    internal override func get(cookie: HTTPCookie) async throws -> String {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
}
