//
//  Work+Receive.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Work {
    public struct Receive {
        
        fileprivate var dispatcher: Dispatcher
        
        internal init(_ dispatcher: Dispatcher) {
            self.dispatcher = dispatcher
        }
        
        internal func sync(_ block: () -> Void) {
            switch dispatcher {
                case .task:    block()
                case .main:    DispatchQueue.main.run(execute: block)
                case .global:  DispatchQueue.global().sync(execute: block)
                
            }
        }
        
        internal func async(_ block: @escaping() -> Void) {
            switch dispatcher {
                case .task:    block()
                case .main:    DispatchQueue.main.async(execute: block)
                case .global:  DispatchQueue.global().async(execute: block)
            }
        }
        
        fileprivate func main_sync(_ block: () -> Void) {
            guard !Thread.isMainThread else {
                return block()
            }
            DispatchQueue.main.sync(execute: block)
        }
    }
}

extension Work.Receive {
    public enum Dispatcher {
        case task
        case main
        case global
    }
}

extension Work.Receive {
    public static func on(_ dispatcher: Dispatcher) -> Work.Receive {
        return Work.Receive(dispatcher)
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
