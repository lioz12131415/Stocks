//
//  SecurableCollectionObserve.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

public protocol SecurableCollectionObserve: SecurableObserve {
    
//    @discardableResult func onRemove(_ block: @escaping() -> Void) -> Self
//    @discardableResult func onAppend(_ block: @escaping() -> Void) -> Self
//    @discardableResult func onInsert(_ block: @escaping() -> Void) -> Self
    @discardableResult func onDecrease(_ block: @escaping() -> Void) -> Self
    @discardableResult func onIncrease(_ block: @escaping() -> Void) -> Self
    
//    @discardableResult func onRemove(receive: Receive, _ block: @escaping() -> Void) -> Self
//    @discardableResult func onAppend(receive: Receive, _ block: @escaping() -> Void) -> Self
    @discardableResult func onDecrease(receive: Receive, _ block: @escaping() -> Void) -> Self
    @discardableResult func onIncrease(receive: Receive, _ block: @escaping() -> Void) -> Self
}

