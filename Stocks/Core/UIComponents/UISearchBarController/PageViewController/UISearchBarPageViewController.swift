//
//  UISearchBarPageViewController.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarPageViewController: UISearchBarBasePageViewController {
    
    typealias Scene  = SearchBarPageViewControllerScene
    typealias Scenes = UISearchBarControllerScenes
    
    fileprivate lazy var scene:  Scene   = Scene()
    fileprivate weak var scenes: Scenes? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageDelegate         = self
        self.pageDataSource       = self
        self.view.backgroundColor = .clear
    }
    
    internal func set(isScrollEnable: Bool) {
        self.isScrollEnable = isScrollEnable
    }
    
    internal func set(scenes: UISearchBarControllerScenes) {
        self.scenes = scenes
        self.scenes?.set(scene: scene)
    }
    
    internal func loadViewControllers(_ controller: UISearchBarController,
                                      _ dataSource: UISearchBarControllerDataSource?) {
        guard let dataSource = dataSource else {
            return
        }
        self.pages.removeAll()
        self.scene.metainformation.removeAll()
        
        for i in 0..<dataSource.numberOfPages(controller) {
            let page  = dataSource.searchBarController(controller, pageForItemAt: i)
            let scene = page.set(scenes, self)
            
            self.pages.append(page)
            self.scene.metainformation.append(scene)
        }
    }
}

extension UISearchBarPageViewController: UISearchBarViewControllerDelegate, UISearchBarViewControllerDataSource {
    func searchBarViewController(_ controller: UISearchBarViewController, bounds: CGRect) {
        self.scene.change(bounds)
    }
    
    func searchBarViewController(_ controller: UISearchBarViewController, contentSize: CGSize) {
        self.scene.change(contentSize)
    }
}

extension UISearchBarPageViewController: UISearchBarPageViewControllerDelegate, UISearchBarPageViewControllerDataSource {
    func pagerViewController(didChange process: CGFloat) {
        /* * * * * * * */
    }
    
    func pagerViewController(didDisplay controller: UISearchBarViewController?, at index: Int) {
        self.scene.metainformation.index(index)
        self.scene.change(controller)
    }
}



