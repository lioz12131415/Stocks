//
//  SecurableObject+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

fileprivate var initialKey: UInt8 = 0

extension SecurableObject {
    internal func remove(observer: NSObject?) {
        guard let observer = observer else {
            return
        }
        let key       = observer.pointer+pointer
        let observes  = observer.map(to: &initialKey)
        guard observes[key] != nil else {
            return
        }
        observes.removeObject(forKey: key)
    }
}

extension SecurableObject {
    @discardableResult internal func observe<O: SecurableObserve>(for observer: NSObject) -> O {
        let key      = observer.pointer+pointer
        let observes = observer.map(to: &initialKey)
        if let observe = observes[key] as? O {
            return observe
        }
        else {
            observes[key] = O(observer, self)
        }
        return observes[key] as! O
    }
}

