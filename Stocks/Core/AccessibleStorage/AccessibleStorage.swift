//
//  AccessibleStorage.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

protocol AccessibleStorage<Observe, Observer>: NSObject {
    associatedtype Observe
    associatedtype Observer: NSObject
    
    func observe(_ target: NSObject) -> Observe
}
