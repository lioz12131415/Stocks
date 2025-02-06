//
//  CrumbRequestsService.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

open class CrumbRequestsService: NetworkService<CrumbEndpoints> {
    
    internal func get(cookie: HTTPCookie) async throws -> String {
        let request = request(.get)
        let session = session(request)

        request?
            .header(field: .accept,    .all)
            .header(field: .userAgent, .mozilla)
                
        return try await get(session).0.string()
    }
}

extension CrumbRequestsService {
    internal static var mock: CrumbRequestsService {
        return CrumbMockRequestsService()
    }
}

extension CrumbRequestsService {
    internal static var `default`: CrumbRequestsService {
        return CrumbRequestsService()
    }
}
