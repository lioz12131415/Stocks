//
//  UISearchBarViewController.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarViewController: UIViewController {
    
    typealias Scene  = SearchBarViewControllerScene
    typealias Scenes = UISearchBarControllerScenes
    
    typealias Delegate   = UISearchBarViewControllerDelegate
    typealias DataSource = UISearchBarViewControllerDataSource
    
    fileprivate lazy var scene:       Scene       = Scene()
    fileprivate lazy var bounds:      Bounds      = Bounds()
    fileprivate lazy var contentSize: ContentSize = ContentSize()
    
    fileprivate weak var scenes:       Scenes?     = nil
    fileprivate weak var delegate:     Delegate?   = nil
    fileprivate weak var dataSource:   DataSource? = nil
    fileprivate lazy var contentInset: ContentInset = ContentInset()

    fileprivate weak var scrollView: UIScrollView? = nil {
        didSet { }
    }
    
    internal override func viewDidLoad() {
        self.viewDidLoad(nil)
    }
    
    internal func viewDidLoad(_ scrollView: UIScrollView?) {
        self.update(scrollView)
    }
    
    internal func set(_ scenes:         Scenes?,
                      _ pageController: UISearchBarPageViewController) -> Scene {
        self.scenes     = scenes
        self.delegate   = pageController
        self.dataSource = pageController
        return scene
    }
    
    fileprivate func update(_ newValue: CGRect) {
        self.dataSource?.searchBarViewController(self, bounds: newValue)
    }
    
    fileprivate func update(_ newValue: CGSize) {
        self.dataSource?.searchBarViewController(self, contentSize: newValue)
    }
    
    fileprivate func update(_ newValue: UIEdgeInsets) {
        // TODO
    }
    
    fileprivate func update(_ scrollView: UIScrollView?) {
        self.contentInset.set(scrollView)
        self.scene.scrollView(scrollView)
        self.contentSize.set(scrollView)
        self.bounds.set(scrollView)
        
        self.bounds.didSet       { [weak self] newValue in self?.update(newValue) }
        self.contentSize.didSet  { [weak self] newValue in self?.update(newValue) }
        self.contentInset.didSet { [weak self] newValue in self?.update(newValue) } // TODO
    }
}

@objc
protocol UISearchBarViewControllerDataSource {
    func searchBarViewController(_ controller: UISearchBarViewController, bounds: CGRect)
    func searchBarViewController(_ controller: UISearchBarViewController, contentSize: CGSize)
}

@objc
protocol UISearchBarViewControllerDelegate {
    
}

