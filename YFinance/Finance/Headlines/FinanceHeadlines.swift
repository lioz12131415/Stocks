//
//  FinanceHeadlines.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

final
public class FinanceHeadlines {
    
    public typealias HeadlinesBlock = (_ headlines:  Headlines) -> Void
    public typealias ResponseBlock  = (_ response: Response<XML.Headlines>) -> Void
    
    fileprivate var _response:        Work = Work()
    fileprivate var _headlines:       Work = Work()
    fileprivate var _requestsService: HeadlineRequestsService
    
    internal init(_ requestsService: HeadlineRequestsService = .`default`) {
        self._requestsService = requestsService
    }
    
    @discardableResult
    public func get(_ worker: Worker) -> AccessibleWork {
        switch worker {
            case .response:  return _response
            case .headlines: return _headlines
        }
    }
    
    @discardableResult
    public func response(for symbol: String, block: @escaping(ResponseBlock)) -> AccessibleWork {
        return _response.run { [weak self] recive in
            guard let self else {
                return recive.sync { block(.empty) }
            }
            let response = try await _requestsService.response(for: symbol)
            recive.sync {
                block(response)
            }
        }
    }
    
    @discardableResult
    public func headlines(for symbol: String, block: @escaping(HeadlinesBlock)) -> AccessibleWork {
        return _headlines.run { [weak self] recive in
            guard let self else {
                return recive.sync { block(.empty) }
            }
            let headlines = try await _requestsService.headlines(for: symbol)
            recive.sync {
                block(headlines)
            }
        }
    }
    
    deinit {
        self._response.stop()
        self._headlines.stop()
    }
}

extension FinanceHeadlines {
    public enum Worker {
        case response
        case headlines
    }
}
