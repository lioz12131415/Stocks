//
//  UISearchBarController.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarController: UIViewController {
    
    typealias Scenes     = UISearchBarControllerScenes
    typealias Delegate   = UISearchBarControllerDelegate
    typealias DataSource = UISearchBarControllerDataSource
    
    typealias PageViewController   = UISearchBarPageViewController
    typealias FieldContainerView   = UISearchBarFieldContainerView
    typealias HeaderContainerView  = UISearchBarHeaderContainerView
    typealias ScrollsContainerView = UISearchBarScrollsContainerView
    
    fileprivate lazy var scenes               = Scenes()
    fileprivate lazy var pageViewController   = PageViewController(0.8)
    fileprivate lazy var fieldContainerView   = FieldContainerView()
    fileprivate lazy var headerContainerView  = HeaderContainerView()
    fileprivate lazy var scrollsContainerView = ScrollsContainerView()
    
    open weak var delegate:   Delegate?   = nil { didSet { set(delegate: delegate) } }
    open weak var dataSource: DataSource? = nil { didSet { set(dataSource: dataSource) } }
    
    internal var headerView: UISearchBarHeaderView? {
        return headerContainerView.header
    }
    
    @IBInspectable var headerHeight: CGFloat = .zero {
        didSet { set(headerHeight: headerHeight) }
    }
    
    @IBInspectable var headerNibName: String = .empty {
        didSet { set(headerNibName: headerNibName) }
    }
    
    @IBInspectable open var isScrollEnable: Bool = true {
        didSet { set(isScrollEnable: isScrollEnable) }
    }
    
    @IBInspectable public var isPagerScrollEnable: Bool = true {
        didSet { set(isPagerScrollEnable: isPagerScrollEnable) }
    }
    
    @IBInspectable var contentInsetAdjustmentBehavior: Bool = true {
        didSet { set(adjustmentBehavior: contentInsetAdjustmentBehavior) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observe()
    }
    
    override func loadView() {
        super.loadView()
        self.pageViewController.set(scenes:   scenes)
        self.fieldContainerView.set(scenes:   scenes)
        self.headerContainerView.set(scenes:  scenes)
        self.scrollsContainerView.set(scenes: scenes)
        
        self.headerContainerView.add(to: self, height: headerHeight)
        self.scrollsContainerView.add(to: self, under: headerContainerView)
        self.fieldContainerView.add(to: scrollsContainerView.containerScrollView.contentView)
        self.pageViewController.add(to: scrollsContainerView.contentView, under: fieldContainerView)
    }
    
    internal func setCurrentIndex(_ newValue: Int, animated: Bool) {
        self.pageViewController.setCurrentIndex(newValue, animated: animated)
    }
    
    fileprivate func observe() {
        self.scenes.fieldContainer?.observe(self)
            .endEditing    { [weak self] in self?.endEditing() }
        self.scenes.fieldContainer?.observe(self)
            .beginEditing  { [weak self] in self?.beginEditing() }
        self.scenes.scrollsContainer?.observe(self)
            .didScroll     { [weak self] scroll in self?.didScroll(scroll) }
        self.scenes.fieldContainer?.observe(self)
            .textDidChange { [weak self] newValue in self?.set(searchText: newValue) }
    }
    
    fileprivate func didScroll(_ scrollView: UIScrollView) {
        self.fieldContainerView.resignResponder()
    }
    
    fileprivate func endEditing() {
        self.delegate?.endEditing?(self)
    }
    
    fileprivate func beginEditing() {
        self.delegate?.beginEditing?(self)
    }
    
    fileprivate func set(delegate: Delegate?) {
        /* * * */
    }
    
    fileprivate func set(dataSource: DataSource?) {
        self.pageViewController.loadViewControllers(self, dataSource)
    }
    
    fileprivate func set(searchText newValue: String) {
        self.delegate?.searchBarController?(self, textDidChange: newValue)
    }
    
    fileprivate func set(isScrollEnable newValue: Bool) {
        self.scrollsContainerView.set(isScrollEnable: newValue)
    }
    
    fileprivate func set(headerNibName newValue: String) {
        self.headerContainerView.loadFromNib(newValue)
    }
    
    fileprivate func set(headerHeight newValue: CGFloat) {
        self.headerContainerView.set(height: newValue)
    }
    
    fileprivate func set(adjustmentBehavior newValue: Bool) {
        self.scrollsContainerView.set(adjustmentBehavior: newValue)
    }
    
    fileprivate func set(isPagerScrollEnable newValue: Bool) {
        self.pageViewController.set(isScrollEnable: newValue)
    }
}

