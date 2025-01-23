//
//  UISearchBarHeaderView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class UISearchBarHeaderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /* *  * */
    }
    
    internal static func nibView(nibName: String) -> UIView? {
        let nib  = UINib(nibName: nibName, bundle: .main)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as? UISearchBarHeaderView
        return view
    }
}


