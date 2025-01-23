//
//  LookupRoute.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final
public class LookupRoute {
    
    public typealias Types = [Type]

    private(set) public var types: Types  = .all
    private(set) public var query: String = .empty
    
    private(set) public var pricing:   Bool = false
    private(set) public var formatted: Bool = false
    
    public init() {
        /* * * */
    }
    
    @discardableResult
    public func query(_ value: String) -> Self {
        self.query = value
        return self
    }
    
    @discardableResult
    public func pricing(_ value: Bool) -> Self {
        self.pricing = value
        return self
    }
    
    @discardableResult
    public func formatted(_ value: Bool) -> Self {
        self.formatted = value
        return self
    }
    
    @discardableResult
    public func types(_ value: `Type`...) -> Self {
        self.types = value
        return self
    }
    
    public func path() -> String {
        return """
        lookup?\
        query=\(query)&\
        type=\(types.joined())&\
        formatted=\(formatted)&\
        fetchPricingData=\(pricing)
        """
    }
    
    public enum `Type`: String {
        case etf
        case all
        case index
        case future
        case equity
        case currency
        case mutualfund
        case cryptocurrency
    }
}

extension Array where Element == LookupRoute.`Type` {
    public static var all: [Element] {
        return [.all]
    }
    
    public func joined() -> String {
        return joined(by: ",") { $0.rawValue }
    }
}
