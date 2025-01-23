//
//  FinanceQuote.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

final
public class FinanceQuote {
    
    public typealias Symbols       = [String]
    public typealias QuotesBlock   = (_ quotes:  [Quote]) -> Void
    public typealias ResponseBlock = (_ response: Response<JSON.Quote>) -> Void
    
    fileprivate var _quotes:   Work
    fileprivate var _response: Work
    fileprivate var _service:  QuoteRequestsService
    
    internal init(_ service: QuoteRequestsService = .`default`) {
        self._quotes   = Work()
        self._response = Work()
        self._service  = service
    }
    
    @discardableResult
    public func get(_ worker: Worker) -> AccessibleWork {
        switch worker {
            case .quotes:   return _quotes
            case .response: return _response
        }
    }
    
    @discardableResult
    public func quotes(for symbols: Symbols, block: @escaping(QuotesBlock)) -> AccessibleWork {
        return _quotes.run { [weak self] recive in
            let quotes = try await self?._service.quotes(for: symbols)
            
            recive.sync {
                block(quotes ?? [])
            }
        }
    }
    
    @discardableResult
    public func response(for symbols: Symbols, block: @escaping(ResponseBlock)) -> AccessibleWork {
        return _response.run { [weak self] recive in
            let response = try await self?._service.response(for: symbols)
            
            recive.sync {
                block(response ?? .empty)
            }
        }
    }
    
    deinit {
        self._quotes.stop()
        self._response.stop()
    }
}

extension FinanceQuote {
    public enum Worker {
        case quotes
        case response
    }
}


