//
//  QuoteStream.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

final
public class QuoteStream: Stream<Quote> {
    
    internal override var ticker: Quote {
        get { super.ticker }
        set { super.ticker = newValue }
    }
    
    fileprivate var cache: QuotesCache {
        return finance.cache.quotes
    }
    
    internal override init(_ ticker: Quote) {
        super.init(ticker)
    }
    
    @discardableResult
    public override func stop() -> Self {
        finance.quote.get(.quotes).stop()
        return self
    }
    
    @discardableResult
    public override func onReceive(_ block: @escaping (ReceiveBlock)) -> Self {
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

extension QuoteStream {
    fileprivate func execute(_ receive:  Receive,
                             _ schedule: Schedule, _ loop: Loop, _ options: Set<CacheOption>) {
        finance.quote.quotes(for: [ticker.symbol]) { [weak self] quotes in
            guard let quote = quotes.first(where: { $0.symbol == self?.ticker.symbol ?? .empty }) else {
                return
            }
            if let cache = self?.cache, options.contains(.update), cache.contains(quote.symbol) {
                self?.cache.update(quote, for: quote.symbol)
            }
            if let cache = self?.cache, options.contains(.save), cache.contains(quote.symbol) {
                self?.cache.save()
            }
            receive.sync {
                self?.receiveBlock?(quote)
            }
        }
        .stop()
        .start(receive: .on(.task), after: schedule, loop: loop)
    }
}

extension QuoteStream {
    internal static var empty: QuoteStream {
        return QuoteStream(.empty)
    }
}
