//
//  UISearchBarBasePageViewController.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarBasePageViewController: UIPageViewController {
     
    typealias Pages      = [UISearchBarViewController]
    typealias Delegate   = UISearchBarPageViewControllerDelegate
    typealias DataSource = UISearchBarPageViewControllerDataSource
    
    internal lazy var pages:          Pages       = []
    internal weak var pageDelegate:   Delegate?   = nil
    internal weak var pageDataSource: DataSource? = nil
    
    internal var scrollView: UIScrollView? {
        return view?.subviews.first as? UIScrollView
    }
    
    internal var currentIndex: Int = .zero {
        didSet { pageDelegate?.pagerViewController?(didDisplay: currentPage, at: currentIndex) }
    }
    
    internal var isScrollEnable: Bool = true {
        didSet { scrollView?.isScrollEnabled = isScrollEnable }
    }
    
    internal var contentOffset: CGPoint = .zero {
        didSet { }
    }
    
    internal var currentPage: UISearchBarViewController? {
        return pages.count == .zero ? nil : pages[currentIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate   = self
        self.dataSource = self
        self.scrollView?.delegate = self
        self.scrollView?.canCancelContentTouches = false
        self.scrollView?.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    internal init(_ pageSpacing: CGFloat) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [
            UIPageViewController.OptionsKey.interPageSpacing: pageSpacing
        ])
    }
    
    internal func load() {
        scroll(to: currentIndex, direction: .forward, animated: false)
    }
    
    internal func reverse(delay: TimeInterval = .zero, animated: Bool = true) {
        guard currentIndex-1 >= 0 else { return }
        scroll(to: currentIndex-1, direction: .reverse, animated: animated, delay: delay)
    }
    
    internal func reverse(index: Int, delay: TimeInterval = .zero, animated: Bool = true) {
        guard index >= 0 else { return }
        scroll(to: index, direction: .reverse, animated: animated, delay: delay)
    }
    
    internal func forward(delay: TimeInterval = .zero, animated: Bool = true) {
        guard currentIndex+1 <= pages.count-1 else { return }
        scroll(to: currentIndex+1, direction: .forward, animated: animated, delay: delay)
    }
    
    internal func forward(index: Int, delay: TimeInterval = .zero, animated: Bool = true) {
        guard index <= pages.count-1 else { return }
        scroll(to: index, direction: .forward, animated: animated, delay: delay)
    }
    
    internal func setCurrentIndex(_ newValue: Int, delay: TimeInterval = .zero, animated: Bool = true) {
        if viewControllers == nil || viewControllers?.isEmpty ?? true {
            scroll(to: newValue, direction: .forward, animated: false)
        }
        switch newValue {
            case let new where new < currentIndex: reverse(index: newValue, delay: delay, animated: animated)
            case let new where new > currentIndex: forward(index: newValue, delay: delay, animated: animated)
        default:
            break
        }
    }
    
    fileprivate func scroll(to index: Int,
                            direction: UIPageViewController.NavigationDirection,
                            animated: Bool, delay: TimeInterval = .zero, callback: (() -> Void)? = nil) {
        guard index <= pages.count-1 else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+delay) { [weak self] in
            guard let self else {
                return
            }
            setViewControllers([pages[index]], direction: direction, animated: animated) { [weak self] finish in
                self?.currentIndex = index
                callback?()
            }
        }
    }
}

extension UISearchBarBasePageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let controller = viewController as? UISearchBarViewController,
              let firstIndex = pages.firstIndex(of: controller) else {
            return nil
        }
        guard firstIndex == 0 else {
            return pages[firstIndex - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let controller = viewController as? UISearchBarViewController,
              let firstIndex = pages.firstIndex(of: controller) else {
            return nil
        }
        guard firstIndex == pages.count - 1 else {
            return pages[firstIndex + 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let controller = viewControllers?.first as? UISearchBarViewController,
              let firstIndex = pages.firstIndex(of: controller), completed else {
            return
        }
        guard self.currentIndex != firstIndex else {
            return
        }
        self.currentIndex = firstIndex
    }
}

extension UISearchBarBasePageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = isScrollEnable
        
        let i = CGFloat(currentIndex)
        let x = scrollView.contentOffset.x
        let w = scrollView.frame.size.width
        
        let newX = (i*w)+(x-w)
        let maxX = scrollView.contentSize.width-w
        let perc = (newX/maxX)*1.0
        
        contentOffset.x = (i*w)+(x-w)
        pageDelegate?.pagerViewController?(didChange: perc)
    }
}


