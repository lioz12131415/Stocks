//
//  AccessibleWork.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public protocol AccessibleWork {
    
    typealias Loop     = Work.Loop
    typealias Receive  = Work.Receive
    typealias Schedule = Work.Schedule
    
    @discardableResult func stop() -> Self
    @discardableResult func start(receive: Receive) -> Self
    @discardableResult func start(receive: Receive, loop: Loop) -> Self
    @discardableResult func start(receive: Receive, after: Schedule) -> Self
    @discardableResult func start(receive: Receive, after: Schedule, loop: Loop) -> Self
}
