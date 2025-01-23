//
//  UIGraphView.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

class UIGraphView: UIView {
    
    private(set) var chart:       Chart       = .empty
    private(set) var bezierPaths: BezierPaths = .empty
    
    @IBInspectable var minusColor: UIColor = .red {
        didSet { }
    }
    
    @IBInspectable var plusColor: UIColor = .green {
        didSet { }
    }
    
    @IBInspectable var dashPlusColor: UIColor = .gray {
        didSet {  }
    }
    
    @IBInspectable var dashMinusColor: UIColor = .gray {
        didSet { }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = false
    }
    
    internal func clear() {
        self.bezierPaths.lines.clear()
        self.bezierPaths.dashLine.clear()
        self.bezierPaths.gradient.clear()
    }
    
    internal func load(with chart: Chart) {
        self.chart = chart
        self.bezierPaths.start(chart:          chart,
                               frame:          frame,
                               layer:          layer,
                               plusColor:      plusColor,
                               minusColor:     minusColor,
                               dashPlusColor:  dashPlusColor,
                               dashMinusColor: dashMinusColor) { [weak self] lines, gradient, dashLine in
            self?.layer.addSublayer(lines.shape_layer)
            self?.layer.addSublayer(gradient.gradient_layer)
            self?.layer.addSublayer(dashLine.shape_layer)
        }
    }
}


