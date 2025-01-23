//
//  Ordered+Observers.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Structures
import Foundation

extension Ordered {
    public class Observers: NSObject {
        
        public typealias Observe = Ordered.Observe
        
        fileprivate var table: MapTable<Observe> = {
            return MapTable<Observe>()
        }()
        
        internal func saved() {
            table.forEach { $0.saved() }
        }
        
        internal func changed() {
            table.forEach { $0.changed() }
        }
        
        internal func removed() {
            table.forEach { $0.removed() }
        }

        internal func updated() {
            table.forEach { $0.updated() }
        }

        public func remove(_ observe: Observe?) {
            self.table.remove(observe)
        }
        
        public func update(_ observe: Observe) -> Observe {
            self.table.update(observe)
            return observe
        }
    }
}
