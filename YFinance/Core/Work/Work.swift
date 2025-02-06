//
//  Work.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

final
public class Work: AccessibleWork {
    
    public typealias Loop     = WorkLoop
    public typealias Schedule = WorkSchedule
    
    public typealias R = Receive
    public typealias S = Scheduler
    public typealias T = Task<Void, Error>
    public typealias B = (R) async throws -> Void
    
    fileprivate var task:      T? = nil
    fileprivate var block:     B? = nil
    fileprivate var scheduler: S? = nil
    
    public var isStarted: Bool {
        return task != nil
    }
    
    public var isCancelled: Bool {
        return task?.isCancelled ?? true
    }
    
    public init() {
        /* * * * * */
    }
    
    @discardableResult
    public func stop() -> Self {
        self.task?.cancel()
        self.task = nil
        return self
    }
    
    @discardableResult
    public func start(receive: Receive) -> Self {
        self.stop()
        self.task = execute(receive, nil, nil)
        return self
    }
    
    @discardableResult
    public func start(receive: Receive, loop: Loop) -> Self {
        self.stop()
        self.task = execute(receive, nil, loop)
        return self
    }
    
    @discardableResult
    public func start(receive: Receive, after: Schedule) -> Self {
        self.stop()
        self.task = execute(receive, after, nil)
        return self
    }
    
    @discardableResult
    public func start(receive: Receive, after: Schedule, loop: Loop) -> Self {
        self.stop()
        self.task = execute(receive, after, loop)
        return self
    }
    
    @discardableResult public func run(_ block: @escaping(B)) -> Self {
        self.block = block
        return self
    }
}

extension Work {
    fileprivate func execute(_ receive: Receive, _ after: Schedule?, _ loop: Loop?) -> T {
        return T {
            try await after?.wait()
            try await block?(receive)
            
            try await loop?.wait {
                try await block?(receive)
            }
        }
    }
}
