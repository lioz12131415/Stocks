//
//  QuoteMockRequestsService.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public class QuoteMockRequestsService: QuoteRequestsService {
    
    public override func quotes(for symbols: [String]) async throws -> [Quote] {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
    
    public override func response(for symbols: [String]) async throws -> Response<JSON.Quote> {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
}
