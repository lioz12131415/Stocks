//
//  FinanceCache.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import SecureData
import Foundation

final
public class FinanceCache {
    
    private(set) public static var get: FinanceCache = FinanceCache()
    
    public var crumb: CrumbCache {
        return CrumbCache.get
    }
    
    private(set) public var charts: ChartsTable = {
        return ChartsTable()
    }()
    
    private(set) public var quotes: QuotesCache = {
        return QuotesCache()
    }()
    
    private(set) public var lookups: LookupsCache = {
        return LookupsCache()
    }()
    
    public func load(_ type: `Type`, _ block: @escaping() -> Void) {
        DispatchQueue.global().async { [weak self] in
            switch type {
                case .quotes:                let _ = self?.quotes
                case .lookups:               let _ = self?.lookups
                case .charts(let r, let g):  let _ = self?.charts[range: r, granularity: g]
            }
            DispatchQueue.main.async(execute: block)
        }
    }
}

extension FinanceCache {
    public enum `Type` {
        case quotes
        case lookups
        case charts(range: Chart.Range, granularity: Chart.Granularity)
    }
}
