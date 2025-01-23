//
//  SearchBarFieldContainerScene.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class SearchBarFieldContainerScene: SearchBarFieldContainerSceneAccessible {
    
    typealias Observe  = SearchBarFieldContainerSceneObserve
    typealias Observer = SearchBarFieldContainerSceneObserver
    
    fileprivate lazy var storage: SearchBarSceneStorage<Observer> = {
        return SearchBarSceneStorage<Observer>()
    }()
    
    internal func endEditing() {
        storage.forEach { $0?.endEditing() }
    }
    
    internal func beginEditing() {
        storage.forEach { $0?.beginEditing() }
    }
    
    internal func buttonClicked() {
        storage.forEach { $0?.buttonClicked() }
    }
    
    internal func textDidChange(_ searchText: String) {
        storage.forEach { $0?.textDidChange(searchText) }
    }
    
    internal func observe(_ target: NSObject) -> Observe {
        return storage.observe(target)
    }
}

protocol SearchBarFieldContainerSceneAccessible: AnyObject {
    func observe(_ target: NSObject) -> SearchBarFieldContainerScene.Observe
}

