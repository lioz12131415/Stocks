//
//  ChartStream.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final
public class ChartStream: Stream<Chart> {
    
    internal override var ticker: Chart {
        get { super.ticker }
        set { super.ticker = newValue }
    }
    
    fileprivate var charts: FinanceChart {
        return finance.charts[range: ticker.range, granularity: ticker.granularity]
    }
    
    fileprivate var cache: OrderedCharts {
        return finance.cache.charts[range: ticker.range, granularity: ticker.granularity]
    }
    
    internal override init(_ ticker: Chart) {
        super.init(ticker)
    }
    
    @discardableResult
    public override func stop() -> Self {
        charts.get(.chart).stop()
        return self
    }
    
    @discardableResult
    public override func onReceive(_ block: @escaping(ReceiveBlock)) -> Self {
        return super.onReceive(block)
    }
      
    @discardableResult
    public override func run(receive: Receive, loop: Loop, cache: [CacheOption] = []) -> Self {
        self.execute(receive, .schedule(0), loop, Set(cache))
        return self
    }
    
    @discardableResult
    public override func run(receive: Receive, after: Schedule, loop: Loop, cache: [CacheOption] = []) -> Self {
        self.execute(receive, after, loop, Set(cache))
        return self
    }
}

extension ChartStream {
    fileprivate func execute(_ receive:  Receive,
                             _ schedule: Schedule, _ loop: Loop, _ options: Set<CacheOption>) {
        charts.chart(for: ticker.symbol) { [weak self] chart in
            if let cache = self?.cache, options.contains(.update), cache.contains(chart.symbol) {
                self?.cache.update(chart)
            }
            if let cache = self?.cache, options.contains(.save), cache.contains(chart.symbol) {
                self?.cache.save(.sync)
            }
            receive.sync {
                self?.receiveBlock?(chart)
            }
        }
        .stop()
        .start(receive: .on(.task), after: schedule, loop: loop)
    }
}

extension ChartStream {
    internal static var empty: ChartStream {
        return ChartStream(.empty)
    }
}
