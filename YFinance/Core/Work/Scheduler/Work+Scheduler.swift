//
//  Work+Scheduler.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Work {
    public struct Scheduler: WorkSchedule, WorkLoop {
        
        private(set) var nanoseconds: UInt64
        
        internal init(_ nanoseconds: UInt64) {
            self.nanoseconds = nanoseconds
        }
        
        public func wait() async throws {
            guard nanoseconds > .zero else {
                return
            }
            try await Task<Never, Never>.sleep(nanoseconds: nanoseconds)
        }
        
        public func wait(_ block: () async throws -> Void) async throws {
            while true {
                try await wait()
                try await block()
            }
        }
    }
}


