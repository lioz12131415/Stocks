//
//  WatchListNoDataView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

class WatchListNoDataView: UIView {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        /* * * */
    }
    
    internal class func loadNib() -> WatchListNoDataView  {
        let nib  = UINib(nibName: "WatchListNoDataView", bundle: Bundle(for: self))
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! WatchListNoDataView
        return view
    }
    
    internal func show() {
        self.update(true)
    }
    
    internal func hide() {
        self.update(false)
    }
    
    internal func bind(to view: UIView, show: Bool) {
        self.insert(to: view, at: .zero)
        self.update(show)
    }
    
    fileprivate func update(_ show: Bool) {
        self.isHidden                 = !(show)
        self.isUserInteractionEnabled = !(isHidden)
        self.isHidden ? superview?.sendSubviewToBack(self) : superview?.bringSubviewToFront(self)
    }
    
    @IBAction func addTouch(_ sender: UIButton) {
        
    }
}

