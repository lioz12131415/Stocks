//
//  UISearchBarContainerScrollContentView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarContainerScrollContentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.backgroundColor = .clear
    }
    
    internal func add(to container: UISearchBarContainerScrollView) {
        translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        
        autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight,
        ]

        widthAnchor.constraint(equalTo:  container.widthAnchor,  constant: 0).isActive = true
        heightAnchor.constraint(equalTo: container.heightAnchor, constant: 0).isActive = true
    }
}

