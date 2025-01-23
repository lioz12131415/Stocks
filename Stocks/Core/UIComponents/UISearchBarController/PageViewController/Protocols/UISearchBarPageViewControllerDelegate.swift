//
//  UISearchBarPageViewControllerDelegate.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

@objc
protocol UISearchBarPageViewControllerDelegate {
    
    @objc
    optional func pagerViewController(didChange process: CGFloat)
    
    @objc
    optional func pagerViewController(didDisplay controller: UISearchBarViewController?, at index: Int)
}
