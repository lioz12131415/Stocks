//
//  UISearchBarScrollsContainerView+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UISearchBarScrollsContainerView {
    internal func add(to controller: UISearchBarController, under headerContainerView: UISearchBarHeaderContainerView) {
        translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(self)
        
        autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight,
        ]
        
        topAnchor.constraint(equalTo:    headerContainerView.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo:   controller.view.leftAnchor).isActive       = true
        rightAnchor.constraint(equalTo:  controller.view.rightAnchor).isActive      = true
        bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive     = true
    }
}
