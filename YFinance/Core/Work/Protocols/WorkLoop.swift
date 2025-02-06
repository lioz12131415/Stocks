//
//  WorkLoop.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public protocol WorkLoop {
    func wait(_ block: () async throws -> Void) async throws
}

extension WorkLoop where Self == Work.Scheduler {
    public static func every(_ seconds: Double) -> WorkLoop {
        return Work.Scheduler(UInt64(seconds * 1_000_000_000))
    }
}
