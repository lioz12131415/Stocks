//
//  UISheetViewScene.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation
import Structures

final class UISheetViewScene: NSObject, AccessibleStorage {
    
    typealias Detent     = UISheetDetent
    typealias Visability = UISheetView.Visability

    typealias Observe  = UISheetViewSceneObserve
    typealias Observer = UISheetViewSceneObserver
    
    private(set) lazy var storage: MapTable<Observer> = {
        MapTable<Observer>()
    }()
        
    internal func didChange(_ progress: CGFloat) {
        storage.forEach { $0.didChange(progress) }
    }
    
    internal func didSet(_ newValue: Detent, _ oldValue: Detent) {
        storage.forEach { $0.didSet(newValue, oldValue) }
    }
    
    internal func willSet(_ newValue: Detent, _ oldValue: Detent) {
        storage.forEach { $0.willSet(newValue, oldValue) }
    }
    
    internal func didSet(_ newValue: Visability, _ oldValue: Visability) {
        storage.forEach { $0.didSet(newValue, oldValue) }
    }
    
    internal func willSet(_ newValue: Visability, _ oldValue: Visability) {
        storage.forEach { $0.willSet(newValue, oldValue) }
    }
    
    func observe(_ target: NSObject) -> Observe {
        return storage.update(
            observer(for: target)
        )
    }
}

