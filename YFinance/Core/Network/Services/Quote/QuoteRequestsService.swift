//
//  QuoteRequestsService.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public class QuoteRequestsService: NetworkService<QuoteEndpoints> {
    
    fileprivate var crumb: CrumbCache {
        return FinanceCache.get.crumb
    }
    
    public func quotes(for symbols: [String]) async throws -> [Quote] {
        let response = try await response(for: symbols)
        let elements = response.data.arrayValue.map(Quote.init)
        return elements
    }
    
    public func response(for symbols: [String]) async throws -> Response<JSON.Quote> {
        let crumb    = try await crumb.fetch()
        let request  = request(.get(symbols: symbols, crumb: crumb.key))
        let session  = session(request)
        do {
            return try await get(session, Response<JSON.Quote>.self)
        } catch let error as HTTPError {
            return try failure(error)
        }
    }
}

extension QuoteRequestsService {
    fileprivate func failure(_ error: HTTPError) throws -> Response<JSON.Quote> {
        guard case .cancelled = error else {
            return .empty
        }
        throw error
    }
}

extension QuoteRequestsService {
    public static var mock: QuoteRequestsService {
        return QuoteMockRequestsService()
    }
}

extension QuoteRequestsService {
    public static var `default`: QuoteRequestsService {
        return QuoteRequestsService()
    }
}
