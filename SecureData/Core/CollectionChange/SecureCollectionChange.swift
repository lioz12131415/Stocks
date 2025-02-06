//
//  SecureCollectionChange.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

final
class SecureCollectionChange {
    
    internal var old: Int
    internal var new: Int
    
    internal init(_ count: Int) {
        self.old = count
        self.new = count
    }
    
    internal func update(_ count: Int, _ obs: Observers<SecureCollectionObserve>) {
        self.old = new
        self.new = count
        self.notify(obs)
    }
    
    fileprivate func notify(_ obs: Observers<SecureCollectionObserve>) {
        if new == .zero && old == .zero {
            return
        }
        switch (new, old) {
            case let c where c.0 > c.1: obs.increased()
            case let c where c.0 < c.1: obs.decreased()
        default:
            obs.updated()
        }
    }
    
    enum `Type` {
        case updated
        case increase
        case decrease
    }
}
