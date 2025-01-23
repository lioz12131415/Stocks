//
//  WatchCell.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

class WatchCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel:       UILabel!
    @IBOutlet weak var symbolLabel:      UILabel!
    @IBOutlet weak var longNameLabel:    UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    @IBOutlet weak var graphView:        UIGraphView!
    @IBOutlet weak var priceChangeView:  IBDesignableView!
    
    internal var chart: Chart = .empty {
        didSet { setInfo() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        super.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.graphView.clear()
    }
    
    fileprivate func setInfo() {
        self.graphView.load(with: chart)
        self.priceLabel.text                 = chart.marketPrice.fmt
        self.symbolLabel.text                = chart.symbol
        self.longNameLabel.text              = chart.absoluteName
        self.priceChangeLabel.text           = chart.marketChange.sgn
        self.priceChangeView.backgroundColor = .color(for: chart.marketChange.fmt)
    }
}

