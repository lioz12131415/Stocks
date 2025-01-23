//
//  LookupsNoDataView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit

class LookupsNoDataView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /* * * * * */
    }
    
    internal class func loadNib() -> LookupsNoDataView  {
        let nib  = UINib(nibName: "LookupsNoDataView", bundle: Bundle(for: self))
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! LookupsNoDataView
        return view
    }

    internal func hide() {
        self.update(false, .empty)
    }
    
    internal func show(_ query: String) {
        self.update(true, query)
    }
    
    internal func bind(to view: UIView) {
        self.insert(to: view, at: .zero)
        self.update(false, .empty)
    }
    
    fileprivate func update(_ show: Bool, _ query: String) {
        self.setInfo(query)
        self.isHidden                 = !(show)
        self.isUserInteractionEnabled = !(isHidden)
        self.isHidden ? superview?.sendSubviewToBack(self) : superview?.bringSubviewToFront(self)
    }
    
    fileprivate func setInfo(_ query: String) {
        self.messageLabel.text = "No results for \"\(query).\""
    }
}
