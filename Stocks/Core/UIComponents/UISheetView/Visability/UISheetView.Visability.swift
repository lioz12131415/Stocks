//
//  UISheetView.Visability.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension UISheetView {
    enum Visability {
        case shown
        case hidden
        
        internal mutating func toggle() {
            self = self == .shown ? .hidden : .shown
        }
    }
}
