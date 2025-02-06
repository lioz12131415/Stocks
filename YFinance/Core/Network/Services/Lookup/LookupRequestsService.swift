//
//  LookupRequestsService.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public class LookupRequestsService: NetworkService<LookupEndpoints> {
    
    public func lookups(for query: String) async throws -> [Lookup] {
        let response = try await response(for: query)
        let elements = response.data.arrayValue.map(Lookup.init)
        return elements
    }
    
    public func response(for query: String) async throws -> Response<JSON.Lookup> {
        let request  = request(.get(query: query))
        let session  = session(request)
        let response = try await get(session, Response<JSON.Lookup>.self)
        return response
    }
}

extension LookupRequestsService {
    public static var mock: LookupRequestsService {
        return LookupMockRequestsService()
    }
}

extension LookupRequestsService {
    public static var `default`: LookupRequestsService {
        return LookupRequestsService()
    }
}
