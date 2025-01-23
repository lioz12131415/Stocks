//
//  ArticlesView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit

class ArticlesView: UISheetView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.config()
    }
    
    internal func config() {
        self.edgeInsets.top(60)
        self.edgeInsets.left(0)
        self.edgeInsets.right(0)
        self.edgeInsets.bottom(0)
        self.ignoreSafeArea.top(false)
        self.ignoreSafeArea.left(true)
        self.ignoreSafeArea.right(true)
        self.ignoreSafeArea.bottom(true)
    }
    
    internal static func loadFromNib() -> ArticlesView {
        let view = UINib(nibName: "ArticlesView", bundle: nil)
        return view.instantiate(withOwner: nil, options: nil)[0] as! ArticlesView
    }
}
