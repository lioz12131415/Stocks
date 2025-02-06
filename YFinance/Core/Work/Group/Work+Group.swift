//
//  Work+Group.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Work {
    final public class Group<T>: AccessibleWork {
        
        public typealias G     = TaskGroup<T>
        public typealias Block = (_ group: inout G, _ receive: R) async -> Void
                
        fileprivate var work:  Work   = .init()
        fileprivate var block: Block? = nil
        
        @discardableResult
        public func stop() -> Self {
            self.work.stop()
            return self
        }
        
        @discardableResult
        public func start(receive: Receive) -> Self {
            self.execute().start(receive: receive)
            return self
        }
        
        @discardableResult
        public func start(receive: Receive, loop: Loop) -> Self {
            self.execute().start(receive: receive, loop: loop)
            return self
        }
        
        @discardableResult
        public func start(receive: Receive, after: Schedule) -> Self {
            self.execute().start(receive: receive, after: after)
            return self
        }
        
        @discardableResult
        public func start(receive: Receive, after: Schedule, loop: Loop) -> Self {
            self.execute().start(receive: receive, after: after, loop: loop)
            return self
        }
        
        @discardableResult public func run(_ block: @escaping(Block)) -> Self {
            self.block = block
            return self
        }
    }
}

extension Work.Group {
    fileprivate func execute() -> AccessibleWork {
        return work.run { [weak self] receive in
            guard let self = self else {
                return
            }
            await withTaskGroup(of: T.self) { group in
                await self.block?(&group, receive)
            }
        }
        .stop()
    }
}
