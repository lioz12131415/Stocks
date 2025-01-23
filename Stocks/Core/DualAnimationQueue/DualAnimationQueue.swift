//
//  DualAnimationQueue.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class DualAnimationQueue {
    
    private(set) var pending: Animation? = nil
    private(set) var current: Animation? = nil
    
    internal func add(_ animation: Animation) {
        guard current == nil else {
            return append(animation)
        }
        return next(animation)
    }
    
    fileprivate func next(_ pending: Animation?) {
        self.current = pending
        self.pending = nil
        
        self.current?.fire { [weak self] in
            self?.next(self?.pending)
        }
    }
    
    fileprivate func append(_ pending: Animation?) {
        guard self.current?.className != pending?.className else {
            return clear(pending)
        }
        self.pending = pending
    }
    
    fileprivate func clear(_ pending: Animation?) {
        guard self.pending?.className != pending?.className else {
            return
        }
        self.pending = nil
    }
}

