//
//  FinanceChart.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

final
public class FinanceChart {
    
    public typealias Symbol        = String
    public typealias ChartBlock    = (_ chart:  Chart) -> Void
    public typealias ResponseBlock = (_ response: Response<JSON.Chart>) -> Void
    
    public typealias Range       = Chart.Range
    public typealias Granularity = Chart.Granularity
    
    fileprivate var _chart:    Work = Work()
    fileprivate var _response: Work = Work()
    
    fileprivate var _range:           Range
    fileprivate var _granularity:     Granularity
    fileprivate var _requestsService: ChartRequestsService
    
    internal init(_ range:           Range,
                  _ granularity:     Granularity,
                  _ requestsService: ChartRequestsService = .`default`) {
        self._range           = range
        self._granularity     = granularity
        self._requestsService = requestsService
    }
    
    @discardableResult
    public func get(_ worker: Worker) -> AccessibleWork {
        switch worker {
            case .chart:    return _chart
            case .response: return _response
        }
    }
    
    @discardableResult
    public func chart(for symbol: Symbol, block: @escaping(ChartBlock)) -> AccessibleWork {
        return _chart.run { [weak self] recive in
            guard let self else {
                return recive.sync { block(.empty) }
            }
            let chart = try await _requestsService.chart(symbol: symbol,
                                                         range: _range, granularity: _granularity)
            recive.sync {
                block(chart)
            }
        }
    }
    
    @discardableResult
    public func response(for symbol: Symbol, block: @escaping(ResponseBlock)) -> AccessibleWork {
        return _response.run { [weak self] recive in
            guard let self else {
                return recive.sync { block(.empty) }
            }
            let response = try await _requestsService.response(symbol: symbol,
                                                               range: _range, granularity: _granularity)
            recive.sync {
                block(response)
            }
        }
    }
    
    deinit {
        self._chart.stop()
        self._response.stop()
    }
}

extension FinanceChart {
    public enum Worker {
        case chart
        case response
    }
}
