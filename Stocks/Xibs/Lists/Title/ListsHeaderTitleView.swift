//
//  ListsHeaderTitleView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit

class ListsHeaderTitleView: UIView {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dateLabel.text = .date("dd MMMM")
    }
    
    internal static func loadFromNib() -> ListsHeaderTitleView {
        let view = UINib(nibName: "ListsHeaderTitleView", bundle: nil)
        return view.instantiate(withOwner: nil, options: nil)[0] as! ListsHeaderTitleView
    }
}


