//
//  ChartMockRequestsService.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public class ChartMockRequestsService: ChartRequestsService {
    
    public override func chart(symbol: String,
                               range: Range, granularity: Granularity) async throws -> Chart {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
    
    public override func response(symbol: String, range: Range,
                                  granularity: Granularity) async throws -> Response<JSON.Chart> {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
}
