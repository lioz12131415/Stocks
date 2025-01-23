//
//  UISearchBarControllerDelegate.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

@objc
protocol UISearchBarControllerDelegate {
    @objc
    optional func endEditing(_ searchBarController: UISearchBarController)
    @objc
    optional func beginEditing(_ searchBarController: UISearchBarController)
    @objc
    optional func searchBarController(_ searchBarController: UISearchBarController, textDidChange searchText: String)
}
