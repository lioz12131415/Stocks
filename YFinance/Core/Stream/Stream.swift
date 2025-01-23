//
//  Stream.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public class Stream<T: Ticker>: NSObject {
    
    public typealias Loop         = Work.Loop
    public typealias Receive      = Work.Receive
    public typealias Schedule     = Work.Schedule
    public typealias ReceiveBlock = (_ newValue: T) -> Void
    
    internal var ticker: T
    internal var receiveBlock: ReceiveBlock? = nil
    
    internal init(_ ticker: T) {
        self.ticker = ticker
    }
    
    @discardableResult public func stop() -> Self {
        return self
    }

    @discardableResult
    public func onReceive(_ block: @escaping(ReceiveBlock)) -> Self {
        self.receiveBlock = block
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

extension Stream {
    public enum CacheOption: String {
        case save
        case update
    }
}

