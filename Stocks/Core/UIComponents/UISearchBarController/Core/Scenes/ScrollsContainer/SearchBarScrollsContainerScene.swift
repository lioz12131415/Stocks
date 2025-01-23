//
//  SearchBarScrollsContainerScene.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class SearchBarScrollsContainerScene: SearchBarScrollsContainerSceneAccessible {

    typealias Observe  = SearchBarScrollsContainerSceneObserve
    typealias Observer = SearchBarScrollsContainerSceneObserver
    
    fileprivate lazy var storage: SearchBarSceneStorage<Observer> = {
        return SearchBarSceneStorage<Observer>()
    }()
    
    internal func didScroll(_ scrollView: UIScrollView) {
        storage.forEach { $0?.didScroll(scrollView) }
    }

    internal func observe(_ target: NSObject) -> Observe {
        return storage.observe(target)
    }
}

protocol SearchBarScrollsContainerSceneAccessible: AnyObject {
    func observe(_ target: NSObject) -> SearchBarScrollsContainerScene.Observe
}

