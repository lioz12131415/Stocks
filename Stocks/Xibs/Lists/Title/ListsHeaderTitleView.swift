//
//  ListsHeaderTitleView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit

class ListsHeaderTitleView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /* * * * * */
    }
    
    internal static func loadFromNib() -> ListsHeaderTitleView {
        let view = UINib(nibName: "ListsHeaderTitleView", bundle: nil)
        return view.instantiate(withOwner: nil, options: nil)[0] as! ListsHeaderTitleView
    }
}


