//
//  UITableView+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UITableView {
    func scrollToTop(animated: Bool = false) {
        guard 0 < numberOfRows(inSection: .zero) else {
            return
        }
        scrollToRow(at: .zero, at: .bottom, animated: animated)
    }
}
