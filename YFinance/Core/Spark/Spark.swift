//
//  Spark.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

open class Spark<T: Ticker>: NSObject {
    
    public typealias Loop         = Work.Loop
    public typealias Receive      = Work.Receive
    public typealias Schedule     = Work.Schedule
    public typealias CacheOption  = Stream<T>.CacheOption
    public typealias ReceiveBlock = (_ newValues: [T]) -> Void
    
    internal var work:    Work
    internal var tickers: Array<T>      = []
    internal var receive: ReceiveBlock? = nil
    
    internal override init() {
        self.work = Work()
    }
    
    internal func prepare(_ tickers: Array<T>) -> Self {
        self.stop()
        self.tickers = tickers
        return self
    }
    
    @discardableResult
    public func stop() -> Self {
        self.work.stop()
        return self
    }
    
    @discardableResult
    public func onReceive(_ block: @escaping(ReceiveBlock)) -> Self {
        self.receive = block
        return self
    }
    
    @discardableResult
    public func run(receive: Receive, loop: Loop, cache: [CacheOption] = []) -> Self {
        return self
    }
    
    @discardableResult
    public func run(receive: Receive, after: Schedule, loop: Loop, cache: [CacheOption] = []) -> Self {
        return self
    }
}

