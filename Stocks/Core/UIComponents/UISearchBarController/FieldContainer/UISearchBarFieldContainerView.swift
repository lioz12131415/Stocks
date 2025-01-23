//
//  UISearchBarFieldContainerView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarFieldContainerView: UIView {
    
    typealias Scene     = SearchBarFieldContainerScene
    typealias Scenes    = UISearchBarControllerScenes
    typealias SearchBar = UISearchBar
    
    fileprivate weak var scenes:    Scenes?   = nil
    fileprivate lazy var scene:     Scene     = Scene()
    fileprivate lazy var searchBar: SearchBar = SearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .clear
        self.commit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.backgroundColor = .clear
        self.commit()
    }
    
    internal func set(scenes: UISearchBarControllerScenes) {
        self.scenes = scenes
        self.scenes?.set(scene: scene)
    }
    
    fileprivate func commit() {
        self.searchBar.add(to: self, top: 4, bottom: 4)        
        self.searchBar.delegate       = self
        self.searchBar.placeholder    = "Search"
        self.searchBar.searchBarStyle = .minimal
    }
    
    fileprivate func endEditing() {
        self.searchBar.showsCancelButton = false
        self.scene.endEditing()
    }
    
    internal func resignResponder() {
        self.searchBar.resignFirstResponder()
    }
}

extension UISearchBarFieldContainerView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.scene.beginEditing()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.scene.buttonClicked()
        self.scene.textDidChange(.empty)
        self.searchBar.resignFirstResponder()
        self.endEditing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.scene.textDidChange(searchText)
    }
}

