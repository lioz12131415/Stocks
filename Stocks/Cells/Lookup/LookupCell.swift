//
//  LookupCell.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance

class LookupCell: UITableViewCell {
    
    @IBOutlet weak var markView: UIView!
    @IBOutlet weak var plusView: UIView!
    
    @IBOutlet weak var priceLabel:       UILabel!
    @IBOutlet weak var symbolLabel:      UILabel!
    @IBOutlet weak var longNameLabel:    UILabel!
    @IBOutlet weak var exchangeLabel:    UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    internal var quote: Quote = .empty {
        didSet { setInfo() }
    }
    
    fileprivate lazy var quotes: QuotesCache = {
        return finance.cache.quotes
    }()
    
    fileprivate lazy var charts: ChartsCache = {
        return finance.cache.charts[range: .d1, granularity: .m2]
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        /* * * */
    }
    
    fileprivate func setInfo() {
        self.update(quote)
        self.symbolLabel.text   = quote.symbol
        self.longNameLabel.text = quote.absoluteName
        self.exchangeLabel.text = quote.exchangeDisplay
        
        self.priceLabel.text            = quote.marketPrice.fmt
        self.priceChangeLabel.text      = quote.marketChange.sgn
        self.priceChangeLabel.textColor = .color(for: quote.marketChange.fmt)
    }
    
    fileprivate func save() {
        self.quotes.save()
        self.charts.save()
    }
    
    fileprivate func push(_ quote: Quote) {
        self.charts.push(quote.chartValue(range: .d1, granularity: .m2), for: quote.symbol)
        self.quotes.push(quote, for: quote.symbol)
        self.save()
    }
    
    fileprivate func delete(_ quote: Quote) {
        self.charts.remove(for: quote.symbol)
        self.quotes.remove(for: quote.symbol)
        self.save()
    }
    
    fileprivate func update(_ quote: Quote) {
        plusView.isHidden =  quotes.contains(quote.symbol)
        markView.isHidden = !quotes.contains(quote.symbol)
    }
    
    @IBAction func actionStateTouch(_ sender: UIButton) {
        self.quotes.contains(quote.symbol) ? delete(quote) : push(quote)
        self.update(quote)
    }
}

