//
//  ChartRequestsService.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public class ChartRequestsService: NetworkService<ChartEndpoints> {
     
    public typealias Range       = Chart.Range
    public typealias Granularity = Chart.Granularity
    
    public func chart(from chart: Chart) async throws -> Chart {
        let response = try await response(symbol: chart.symbol, range: chart.range, granularity: chart.granularity)
        return Chart(from: response.data)
    }
    
    public func chart(symbol: String, range: Range, granularity: Granularity) async throws -> Chart {
        let response = try await response(symbol: symbol, range: range, granularity: granularity)
        return Chart(from: response.data)
    }
    
    public func response(symbol: String, range: Range, granularity: Granularity) async throws -> Response<JSON.Chart> {
        let request  = request(.get(symbol: symbol, range: range, granularity: granularity))
        let session  = session(request)
        let response = try await get(session, Response<JSON.Chart>.self)
        return response
    }
}

extension ChartRequestsService {
    public static var mock: ChartRequestsService {
        return ChartMockRequestsService()
    }
}

extension ChartRequestsService {
    public static var `default`: ChartRequestsService {
        return ChartRequestsService()
    }
}
