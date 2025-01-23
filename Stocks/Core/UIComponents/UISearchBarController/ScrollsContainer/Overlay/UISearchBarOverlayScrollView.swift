//
//  UISearchBarOverlayScrollView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarOverlayScrollView: UIScrollView {
    
    typealias ContentOffsets = [Int: CGFloat]
    
    internal lazy var contentOffsets: ContentOffsets = {
        return ContentOffsets()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commit()
    }
    
    fileprivate func commit() {
        self.layer.zPosition                = .greatestFiniteMagnitude
        self.backgroundColor                = .clear
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
        self.contentInsetAdjustmentBehavior = .always
    }
    
    internal func isScrollEnabled(_ newValue: Bool) {
        isScrollEnabled = newValue
    }
    
    internal func adjustmentBehavior(_ newValue: Bool) {
        contentInsetAdjustmentBehavior = newValue ? .always : .never
    }
    
    internal func change(index: Int, or value: CGFloat) {
        contentOffset.y = contentOffsets[index] ?? value
    }
    
    internal func contentSize(with rect: CGRect, size: CGSize, searchBarHeight: CGFloat) {
        contentSize = .init(width: size.width, height: size.height)
    }
    
    internal func scrollView(_ newValue: UIScrollView?) {
        newValue?.bounces                        = bounces
        newValue?.scrollsToTop                   = false
        newValue?.showsHorizontalScrollIndicator = false
        newValue?.panGestureRecognizer.require(toFail: panGestureRecognizer)
    }
}

