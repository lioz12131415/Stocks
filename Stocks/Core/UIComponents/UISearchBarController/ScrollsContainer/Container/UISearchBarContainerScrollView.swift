//
//  UISearchBarContainerScrollView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarContainerScrollView: UIScrollView {
    
    private(set) var contentView: UISearchBarContainerScrollContentView = {
        return UISearchBarContainerScrollContentView()
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commit()
        self.contentView.add(to: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commit()
        self.contentView.add(to: self)
    }
    
    fileprivate func commit() {
        self.bounces                        = true
        self.scrollsToTop                   = false
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
        
        self.backgroundColor                = .clear
        self.contentInsetAdjustmentBehavior = .never
    }
    
    internal func isScrollEnabled(_ newValue: Bool) {
        isScrollEnabled = newValue
    }
    
    internal func contentSize(with rect: CGRect, size: CGSize, searchBarHeight: CGFloat) {
        contentSize = .init(width: size.width, height: rect.height+searchBarHeight)
    }
}
