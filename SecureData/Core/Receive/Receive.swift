//
//  Receive.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public struct Receive {
    
    fileprivate var dispatcher: Dispatcher
    
    internal init(_ dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }
    
    public static func on(_ dispatcher: Dispatcher) -> Receive {
        return Receive(dispatcher)
    }
    
    internal func sync(_ block: () -> Void) {
        switch dispatcher {
            case .main:    DispatchQueue.main.run(execute: block)
            case .global:  DispatchQueue.global().sync(execute: block)
            case .current: block()
        }
    }
    
    internal func async(_ block: @escaping() -> Void) {
        switch dispatcher {
            case .main:    DispatchQueue.main.async(execute: block)
            case .global:  DispatchQueue.global().async(execute: block)
            case .current: block()
        }
    }
}

extension Receive {
    public enum Dispatcher {
        case main
        case global
        case current
    }
}

extension DispatchQueue {
    fileprivate func run(execute block: () -> Void) {
        guard !Thread.isMainThread else {
            return block()
        }
        DispatchQueue.main.sync(execute: block)
    }
}
