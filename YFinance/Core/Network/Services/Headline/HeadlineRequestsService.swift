//
//  HeadlineRequestsService.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public class HeadlineRequestsService: NetworkService<HeadlineEndpoints> {
     
    public func headlines(for symbol: String) async throws -> Headlines {
        let response = try await response(for: symbol)
        return Headlines(from: response.data)
    }
    
    public func response(for symbol: String) async throws -> Response<XML.Headlines> {
        let request  = request(.get(symbol: symbol))
        let session  = session(request)
        let response = try await get(session, XML.self)
        return Response<XML.Headlines>(from: response.headlines(symbol))
    }
}

extension HeadlineRequestsService {
    public static var mock: HeadlineRequestsService {
        return HeadlineMockRequestsService()
    }
}

extension HeadlineRequestsService {
    public static var `default`: HeadlineRequestsService {
        return HeadlineRequestsService()
    }
}
