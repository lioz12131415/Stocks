//
//  Ordered+Associated.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

fileprivate var initialKey: UInt8 = 0

extension Ordered {
    @discardableResult internal func remove(observer: NSObject?) -> Observe? {
        guard let observer = observer else {
            return nil
        }
        let key       = observer.pointer+pointer
        let observes  = observer.map(to: &initialKey)
        guard let observe = observes[key] as? Observe else {
            return nil
        }
        observes.removeObject(forKey: key)
        return observe
    }
}

extension Ordered {
    @discardableResult internal func observe(for observer: NSObject) -> Observe {
        let key      = observer.pointer+pointer
        let observes = observer.map(to: &initialKey)
        if let observe = observes[key] as? Observe {
            return observe
        }
        else {
            observes[key] = Observe(self, observer)
        }
        return observes[key] as! Observe
    }
}

