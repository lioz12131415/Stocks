//
//  ListsHeaderChartCell.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance

class ListsHeaderChartCell: UICollectionViewCell {
    
    @IBOutlet weak var graphView:        UIGraphView!
    @IBOutlet weak var priceLabel:       UILabel!
    @IBOutlet weak var symbolLabel:      UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    internal var chart: Chart = .empty {
        didSet { setInfo() }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        /* * * */
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.graphView.clear()
    }
    
    fileprivate func setInfo() {
        self.graphView.load(with: chart)
        self.priceLabel.text            = chart.marketPrice.fmt
        self.symbolLabel.text           = chart.symbol
        self.priceChangeLabel.text      = chart.marketChange.sgn
        self.priceChangeLabel.textColor = .color(for: chart.marketChange.fmt)
    }
}
