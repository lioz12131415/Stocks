//
//  Observers.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Structures
import Foundation

class Observers<O: SecurableObserve>: NSObject {
    
    fileprivate var table: MapTable<O> = {
        return MapTable<O>()
    }()
    
    internal func remove(_ observe: O?) {
        self.table.remove(observe)
    }
    
    internal func update(_ observe: O) -> O {
        self.table.update(observe)
        return observe
    }
    
    internal func saved() where O: SecureObserve {
        table.forEach { $0.saved() }
    }
    
    internal func updated() where O: SecureObserve {
        table.forEach { $0.updated() }
    }
    
    internal func increased() where O: SecureCollectionObserve {
        table.forEach { $0.increased() }
    }
    
    internal func decreased() where O: SecureCollectionObserve {
        table.forEach { $0.decreased() }
    }
}

