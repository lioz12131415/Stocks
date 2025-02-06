//
//  QuoteRoute.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

final
public class QuoteRoute {
    
    public typealias Fields  = [Field]
    public typealias Symbols = [String]

    private(set) public var fields:  Fields  = []
    private(set) public var symbols: Symbols = []
    
    private(set) public var crumb:     String  = .empty
    private(set) public var formatted: Bool    = false
    
    public init() {
        /* * * * * */
    }
    
    @discardableResult
    public func crumb(_ value: String) -> Self {
        self.crumb = value
        return self
    }
    
    @discardableResult
    public func fields(_ value: Fields) -> Self {
        self.fields = value
        return self
    }
        
    @discardableResult
    public func formatted(_ value: Bool) -> Self {
        self.formatted = value
        return self
    }
    
    @discardableResult
    public func fields(_ value: Field...) -> Self {
        self.fields = value
        return self
    }
    
    @discardableResult
    public func symbols(_ value: Symbols) -> Self {
        self.symbols = value
        return self
    }
    @discardableResult
    public func symbols(_ value: String...) -> Self {
        self.symbols = value
        return self
    }
    
    public func path() -> String {
        return """
        quote?\
        symbols=\(symbols.joined(by: ",") { $0 })\
        &crumb=\(crumb)&formatted=\(formatted)&fields=\(fields.joined())
        """
    }
    
    public enum Field: String {
        case longName
        case marketCap
        case shortName
        case toCurrency
        case toExchange
        case indicators
        case stockStory
        case fromExchange
        case fromCurrency
        case preMarketTime
        case preMarketPrice
        case postMarketTime
        case messageBoardId
        case preMarketChange
        case postMarketPrice
        case fiftyTwoWeekLow
        case underlyingSymbol
        case fiftyTwoWeekHigh
        case postMarketChange
        case regularMarketOpen
        case regularMarketTime
        case headSymbolAsString
        case regularMarketPrice
        case regularMarketChange
        case regularMarketVolume
        case regularMarketSource
        case preMarketChangePercent
        case postMarketChangePercent
        case underlyingExchangeSymbol
        case regularMarketChangePercent
    }
}

extension Array where Element == QuoteRoute.Field {
    public func joined() -> String {
        return joined(by: ",") { $0.rawValue }
    }
}


