//
//  ListsVC.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class ListsVC: UISearchBarController {
    
    fileprivate lazy var viewControllers: [UISearchBarViewController] = [
        watch, lookups,
    ]
    
    fileprivate lazy var lookups: LookupsVC = {
        return LookupsVC.instance()
    }()
    
    fileprivate lazy var watch: WatchListVC = {
        return WatchListVC.instance()
    }()
    
    fileprivate lazy var articlesView: ArticlesView = {
        return ArticlesView.loadFromNib()
    }()
    
    fileprivate var listsHeaderView: ListsHeaderView? {
        return super.headerView as? ListsHeaderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate   = self
        self.dataSource = self
        self.setCurrentIndex(0, animated: false)
        
        self.articlesView.bind(to: view, detents: [.large(), .medium(), .small(90)])
        self.articlesView.show()
        self.observe()
    }

    fileprivate func observe() {
        self.articlesView.observe(self).didChange { [weak self] progress in
            progress == 1.0 ? self?.listsHeaderView?.chartsCollectionView.show() :
                              self?.listsHeaderView?.chartsCollectionView.hide()
        }
    }
}

extension ListsVC: UISearchBarController.Delegate {
    func endEditing(_ searchBarController: UISearchBarController) {
        self.articlesView.show(animation: .animate(duration: 0.2))
    }
    
    func beginEditing(_ searchBarController: UISearchBarController) {
        self.articlesView.hide(animation: .animate(duration: 0.2))
    }
    
    func searchBarController(_ searchBarController: UISearchBarController, textDidChange searchText: String) {
        self.lookups.lookup(for: searchText)
        self.setCurrentIndex(searchText == .empty ? 0 : 1, animated: false)
    }
}

extension ListsVC: UISearchBarController.DataSource {
    func numberOfPages(_ searchBarController: UISearchBarController) -> Int {
        return viewControllers.count
    }
    
    func searchBarController(_ searchBarController: UISearchBarController, pageForItemAt index: Int) -> UISearchBarViewController {
        return viewControllers[index]
    }
}


