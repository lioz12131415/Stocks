//
//  SearchBarPageViewControllerSceneMetadata.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

final class SearchBarPageViewControllerSceneMetainformation: SearchBarPageViewControllerSceneMetadata {
    
    typealias Scenes = [SearchBarViewControllerScene]
    
    private(set) var index:  Int    = 0
    private(set) var scenes: Scenes = []
    
    internal var contentSize: CGSize? {
        return scrollView?.contentSize
    }
        
    internal var scrollView: UIScrollView? {
        return scenes[index].scrollView
    }
    
    internal var contentInset: UIEdgeInsets? {
        return scrollView?.contentInset
    }
    
    internal var scrollViews: [UIScrollView?] {
        return scenes.map { $0.scrollView }
    }
    
    internal func removeAll() {
        self.scenes.removeAll()
    }
    
    internal func index(_ newValue: Int) {
        self.index = newValue
    }
    
    internal func append(_ newScene: SearchBarViewControllerScene) {
        self.scenes.append(newScene)
    }
}

protocol SearchBarPageViewControllerSceneMetadata {
    var index:        Int             { get }
    var contentSize:  CGSize?         { get }
    var contentInset: UIEdgeInsets?   { get }
    
    var scrollView:   UIScrollView?   { get }
    var scrollViews:  [UIScrollView?] { get }
}

