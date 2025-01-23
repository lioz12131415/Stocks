//
//  UISearchBarFieldContainerView+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UISearchBarFieldContainerView {
    internal func add(to contentView: UISearchBarContainerScrollContentView) {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo:   contentView.topAnchor,   constant: +00),
            leftAnchor.constraint(equalTo:  contentView.leftAnchor,  constant: +10),
            rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}

