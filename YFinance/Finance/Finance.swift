//
//  Finance.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final
public class Finance {
    
    fileprivate weak var target: NSObject? = nil {
        didSet { /* * * */ }
    }
    
    private(set) public lazy var cache: FinanceCache = {
        return FinanceCache()
    }()
    
    private(set) public lazy var quote: FinanceQuote = {
        return FinanceQuote(.default)
    }()
    
    private(set) public lazy var charts: FinanceCharts = {
        return FinanceCharts()
    }()
    
    private(set) public lazy var lookup: FinanceLookup = {
        return FinanceLookup(.default)
    }()
    
    internal init(_ target: NSObject? = nil) {
        self.target = target
    }
        
    public func stream(_ chart: Chart) -> ChartStream {
        return target?.stream(for: chart) ?? .empty
    }
    
    public func stream(_ quote: Quote) -> QuoteStream {
        return target?.stream(for: quote) ?? .empty
    }
    
    public func spark(_ charts: [Chart]) -> ChartsSpark {
        return target?.spark(for: charts) ?? .empty
    }
}


