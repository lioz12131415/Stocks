//
//  FinanceCache.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final
public class FinanceCache {
    public var charts: ChartsCache {
        return ChartsCache.get
    }
    
    public var quotes: OrderedQuotes {
        return QuotesCache.get.elements
    }
    
    public var lookups: OrderedLookups {
        return LookupsCache.get.elements
    }
    
    public func load(_ type: `Type`, _ block: @escaping() -> Void) {
        DispatchQueue.global().async { [weak self] in
            switch type {
                case .charts:  let _ = self?.charts
                case .quotes:  let _ = self?.quotes
                case .lookups: let _ = self?.lookups
            }
            DispatchQueue.main.async(execute: block)
        }
    }
}

extension FinanceCache {
    public enum `Type` {
        case charts
        case quotes
        case lookups
    }
}
