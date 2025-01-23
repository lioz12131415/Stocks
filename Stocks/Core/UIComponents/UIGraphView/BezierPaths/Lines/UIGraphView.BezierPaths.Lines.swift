//
//  UIGraphView.BezierPaths.Lines.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

extension UIGraphView.BezierPaths {
    class Lines {
        
        internal var shape_layer: CAShapeLayer = CAShapeLayer()
        internal var bezier_path: UIBezierPath = UIBezierPath()
        
        internal func clear() {
            shape_layer.removeFromSuperlayer()
            shape_layer = CAShapeLayer()
        }
        
        internal func set(chart:      Chart,
                          frame:      CGRect,
                          plusColor:  UIColor,
                          minusColor: UIColor,
                          bezierPath: UIBezierPath) {

            let sign    = chart.marketChange.raw.sign
            bezier_path = bezierPath
            shape_layer = CAShapeLayer()
            
            shape_layer.path        = bezierPath.cgPath
            shape_layer.lineWidth   = CGFloat.init(1.5)
            shape_layer.fillColor   = UIColor.clear.cgColor
            shape_layer.strokeColor = sign == .minus ? minusColor.cgColor : plusColor.cgColor
        }
    }
}
