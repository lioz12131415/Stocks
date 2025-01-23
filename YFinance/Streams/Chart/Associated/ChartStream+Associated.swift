//
//  FinanceChartStream+Associated.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

fileprivate var initialKey: UInt8 = 0

extension NSObject {
    internal func stream(for chart: Chart) -> ChartStream {
        let key     = pointer+"\(chart.symbol)\(chart.range)\(chart.granularity)"
        let streams = map(to: &initialKey)
        
        if let stream = streams[key] as? ChartStream {
            return stream
        }
        else {
            streams[key] = ChartStream(chart)
        }
        return streams[key] as! ChartStream
    }
}
