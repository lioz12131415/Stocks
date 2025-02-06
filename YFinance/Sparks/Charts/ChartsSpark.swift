//
//  ChartsSpark.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

final
public class ChartsSpark: Spark<Chart> {

    override var tickers: Array<Chart> {
        get { super.tickers }
        set { super.tickers = newValue }
    }
    
    fileprivate lazy var service: ChartRequestsService = {
        return .default
    }()
        
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
        self.group.stop()
    }
}

extension ChartsSpark {
    fileprivate func execute(_ receive:  Receive,
                             _ schedule: Schedule, _ loop: Loop, _ options: Set<CacheOption>) {
        guard !tickers.isEmpty else {
            return
        }
        group.run { [weak self] group, receive in
            guard let self = self else {
                return
            }
            let charts     = tickers
            var dictionary = Dictionary<String, Chart>()
            
            for chart in charts {
                group.addTask { try? await self.service.chart(from: chart) }
            }
            for await chart in group {
                self.update(chart, &dictionary, options: options)
            }
            receive.sync {
                self.receive?(charts.compactMap { dictionary[$0.symbol] })
            }
        }
        .stop()
        .start(receive: receive, after: schedule, loop: loop)
    }
}

extension ChartsSpark {
    fileprivate func update(_ chart: Chart?,
                            _ dictionary: inout [String: Chart], options: Set<CacheOption>) {
        guard let chart = chart else {
            return
        }
        let cache    = finance.cache.charts[range: chart.range, granularity: chart.granularity]
        let contains = cache.contains(chart.symbol)
        
        if options.contains(.update), contains {
            cache.update(chart, for: chart.symbol)
        }
        if options.contains(.save), contains {
            cache.save()
        }
        dictionary.updateValue(chart, forKey: chart.symbol)
    }
}

extension ChartsSpark {
    internal static var empty: ChartsSpark {
        return ChartsSpark()
    }
}

