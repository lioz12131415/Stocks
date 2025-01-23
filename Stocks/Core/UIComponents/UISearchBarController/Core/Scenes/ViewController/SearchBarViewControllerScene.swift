//
//  SearchBarViewControllerScene.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class SearchBarViewControllerScene: NSObject, SearchBarViewControllerSceneObserve {
    
    private(set) weak var scrollView: UIScrollView? = nil {
        didSet { }
    }
    
    internal func scrollView(_ newValue: UIScrollView?) {
        self.scrollView = newValue
    }
}

protocol SearchBarViewControllerSceneObserve {
    var scrollView: UIScrollView? { get }
}

