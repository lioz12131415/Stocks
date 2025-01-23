//
//  SearchBarPageViewControllerSceneObserver.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class SearchBarPageViewControllerSceneObserver: NSObject, SearchBarPageViewControllerSceneObserve {
    
    fileprivate var boundsBlock:         ((CGRect) -> Void)?
    fileprivate var contentSizeBlock:    ((CGSize) -> Void)?
    fileprivate var viewControllerBlock: ((UISearchBarViewController?) -> Void)?
    
    internal func change(_ bounds: CGRect) {
        self.boundsBlock?(bounds)
    }
    
    internal func change(_ contentSize: CGSize) {
        self.contentSizeBlock?(contentSize)
    }
    
    internal func change(_ viewController: UISearchBarViewController?) {
        self.viewControllerBlock?(viewController)
    }
    
    internal func didChange(bounds block: @escaping(CGRect) -> Void) {
        self.boundsBlock = block
    }
    
    internal func didChange(contentSize block: @escaping(CGSize) -> Void) {
        self.contentSizeBlock = block
    }
    
    internal func didChange(viewController block: @escaping(UISearchBarViewController?) -> Void) {
        self.viewControllerBlock = block
    }
}

protocol SearchBarPageViewControllerSceneObserve {
    func didChange(bounds         block: @escaping(CGRect) -> Void)
    func didChange(contentSize    block: @escaping(CGSize) -> Void)
    func didChange(viewController block: @escaping(UISearchBarViewController?) -> Void)
}


