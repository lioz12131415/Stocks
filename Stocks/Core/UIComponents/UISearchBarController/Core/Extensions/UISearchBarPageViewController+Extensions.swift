//
//  UISearchBarPageViewController+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UISearchBarPageViewController {
    internal func add(to contentView: UISearchBarContainerScrollContentView, under fieldContainerView: UISearchBarFieldContainerView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo:    fieldContainerView.bottomAnchor),
            view.leftAnchor.constraint(equalTo:   contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo:  contentView.rightAnchor),
            view.widthAnchor.constraint(equalTo:  contentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
}
