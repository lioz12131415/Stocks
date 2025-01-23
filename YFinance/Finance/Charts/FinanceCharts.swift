//
//  FinanceCharts.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

final
public class FinanceCharts {
    
    public typealias Range       = Chart.Range
    public typealias Granularity = Chart.Granularity
    
    fileprivate var map: [String: FinanceChart] = [:]
    
    public subscript(range r: Range, granularity g: Granularity) -> FinanceChart {
        return get(r, g)
    }
    
    fileprivate func get(_ r: Range, _ g: Granularity) -> FinanceChart {
        guard let finance = map["\(r.rawValue)\(g.rawValue)"] else {
            return create(r, g)
        }
        return finance
    }
    
    fileprivate func create(_ r: Range, _ g: Granularity) -> FinanceChart {
        map["\(r.rawValue)\(g.rawValue)"] = FinanceChart(r, g)
        return map["\(r.rawValue)\(g.rawValue)"]!
    }
}

