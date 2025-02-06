//
//  SecurableObserve.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public protocol SecurableObserve: NSObject {
        
    func remove()
    init(_ observer: NSObject?, _ secureObject: SecurableObject?)
    
    @discardableResult func onSave  (_ block: @escaping() -> Void) -> Self
    @discardableResult func onUpdate(_ block: @escaping() -> Void) -> Self
    
    @discardableResult func onSave  (receive: Receive, _ block: @escaping() -> Void) -> Self
    @discardableResult func onUpdate(receive: Receive, _ block: @escaping() -> Void) -> Self
}

