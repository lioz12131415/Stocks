//
//  LookupMockRequestsService.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public class LookupMockRequestsService: LookupRequestsService {
    
    public override func lookups(for query: String) async throws -> [Lookup] {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
    
    public override func response(for query: String) async throws -> Response<JSON.Lookup> {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
}
