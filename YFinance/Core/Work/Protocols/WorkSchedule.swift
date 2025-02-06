//
//  WorkSchedule.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public protocol WorkSchedule {
    func wait() async throws
}

extension WorkSchedule where Self == Work.Scheduler {
    public static func schedule(_ seconds: Double) -> WorkSchedule {
        return Work.Scheduler(UInt64(seconds * 1_000_000_000))
    }
}
