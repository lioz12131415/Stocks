//
//  UICollectionView+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UICollectionView {
    internal func register(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: .main)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
}

