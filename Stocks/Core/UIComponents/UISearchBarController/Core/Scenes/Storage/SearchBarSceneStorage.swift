//
//  SearchBarSceneStorage.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Structures
import Foundation

final class SearchBarSceneStorage<Observer: NSObject>: NSObject {
    
    private(set) lazy var storage: MapTable<Observer> = {
        MapTable<Observer>()
    }()
    
    internal func forEach(_ body: (Observer?) -> Void) {
        storage.forEach(body)
    }
    
    internal func observe(_ target: NSObject) -> Observer {
        return storage.update(
            observer(for: target)
        )
    }
}

