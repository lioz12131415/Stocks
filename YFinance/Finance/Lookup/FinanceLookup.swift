//
//  FinanceLookup.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

final
public class FinanceLookup {
    
    public typealias LookupsBlock  = (_ lookups: [Lookup]) -> Void
    public typealias ResponseBlock = (_ response: Response<JSON.Lookup>) -> Void
    
    fileprivate var _lookups:  Work
    fileprivate var _response: Work
    fileprivate var _service:  LookupRequestsService
    
    internal init(_ service: LookupRequestsService = .`default`) {
        self._lookups  = Work()
        self._response = Work()
        self._service  = service
    }
    
    @discardableResult
    public func get(_ worker: Worker) -> AccessibleWork {
        switch worker {
            case .lookups:  return _lookups
            case .response: return _response
            
        }
    }
    
    @discardableResult
    public func lookups(for query: String, block: @escaping(LookupsBlock)) -> AccessibleWork {
        return _lookups.run { [weak self] recive in
            let lookups = try await self?._service.lookups(for: query)
            
            recive.sync {
                block(lookups ?? [])
            }
        }
    }
    
    @discardableResult
    public func response(for query: String, block: @escaping(ResponseBlock)) -> AccessibleWork {
        return _response.run { [weak self] recive in
            let response = try await self?._service.response(for: query)
            
            recive.sync {
                block(response ?? .empty)
            }
        }
    }
    
    deinit {
        self._lookups.stop()
        self._response.stop()
    }
}

extension FinanceLookup {
    public enum Worker {
        case lookups
        case response
    }
}
