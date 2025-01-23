//
//  UISearchBarControllerDataSource.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

@objc
protocol UISearchBarControllerDataSource {
    func numberOfPages(_ searchBarController: UISearchBarController) -> Int
    func searchBarController(_ searchBarController: UISearchBarController, pageForItemAt index: Int) -> UISearchBarViewController
}

