//
//  SearchBarPageViewControllerScene.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class SearchBarPageViewControllerScene: SearchBarPageViewControllerSceneAccessible {
    
    typealias Observe         = SearchBarPageViewControllerSceneObserve
    typealias Observer        = SearchBarPageViewControllerSceneObserver
    typealias MetaData        = SearchBarPageViewControllerSceneMetadata
    typealias Metainformation = SearchBarPageViewControllerSceneMetainformation
    
    fileprivate lazy var storage: SearchBarSceneStorage<Observer> = {
        return SearchBarSceneStorage<Observer>()
    }()
    
    internal lazy var metainformation: Metainformation = {
        return Metainformation()
    }()
    
    internal var metadata: MetaData {
        return metainformation
    }

    internal func change(_ bounds: CGRect) {
        storage.forEach { $0?.change(bounds) }
    }
    
    internal func change(_ contentSize: CGSize) {
        storage.forEach { $0?.change(contentSize) }
    }
    
    internal func change(_ viewController: UISearchBarViewController?) {
        storage.forEach { $0?.change(viewController) }
    }
    
    internal func observe(_ target: NSObject) -> Observe {
        return storage.observe(target)
    }
}

protocol SearchBarPageViewControllerSceneAccessible: AnyObject {
    var metadata: SearchBarPageViewControllerScene.MetaData { get }
    func observe(_ target: NSObject) -> SearchBarPageViewControllerScene.Observe
}


