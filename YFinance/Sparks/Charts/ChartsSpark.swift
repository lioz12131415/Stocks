//
//  ChartsSpark.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final
public class ChartsSpark: Spark<Chart> {

    override var tickers: Array<Chart> {
        get { super.tickers }
        set { super.tickers = newValue }
    }
        
    @discardableResult
    public override func stop() -> Self {
        return super.stop()
    }
    
    @discardableResult
    public override func onReceive(_ block: @escaping(ReceiveBlock)) -> Self {
        return super.onReceive(block)
    }
    
    @discardableResult
    public override func run(receive: Receive,
                             loop: Loop, cache: [Spark<Chart>.CacheOption] = []) -> Self {
        self.execute(receive, .schedule(0), loop, Set(cache))
        return self
    }
    
    @discardableResult
    public override func run(receive: Receive,
                             after: Schedule, loop: Loop, cache: [CacheOption] = []) -> Self {
        self.execute(receive, after, loop, Set(cache))
        return self
    }
    
    deinit {
        work.stop()
    }
}

extension ChartsSpark {
    fileprivate func execute(_ receive:  Receive,
                             _ schedule: Schedule, _ loop: Loop, _ options: Set<CacheOption>) {
        guard !tickers.isEmpty else {
            return
        }
        work.run { [weak self] receive in
            guard let self = self else {
                return
            }
            
            let c = finance.cache
            var d = Dictionary<String, Chart>()
            let s = ChartRequestsService.default
            await withTaskGroup(of: Chart?.self) { group in
                for c in self.tickers {
                    group.addTask {
                        try? await s.chart(symbol: c.symbol, range: c.range, granularity: c.granularity)
                    }
                }
                for await chart in group {
                    guard let chart = chart else {
                        continue
                    }
                    self.update(chart, c, options: options)
                    d.updateValue(chart, forKey: chart.symbol)
                }
            }
            receive.sync {
                self.receive?(self.tickers.compactMap { d[$0.symbol] })
            }
        }
        .stop()
        .start(receive: receive, after: schedule, loop: loop)
    }
}

extension ChartsSpark {
    fileprivate func update(_ chart: Chart, _ cache: FinanceCache, options: Set<CacheOption>) {
        let cache    = cache.charts[range: chart.range, granularity: chart.granularity]
        let contains = cache.contains(chart.symbol)
        
        if options.contains(.update), contains {
            cache.update(chart)
        }
        if options.contains(.save), contains {
            cache.save(.sync)
        }
    }
}

extension ChartsSpark {
    internal static var empty: ChartsSpark {
        return ChartsSpark()
    }
}


