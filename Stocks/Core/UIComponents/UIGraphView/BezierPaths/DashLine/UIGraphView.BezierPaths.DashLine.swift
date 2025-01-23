//
//  UIGraphView.BezierPaths.DashLine.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

extension UIGraphView.BezierPaths {
    class DashLine {
        
        internal var shape_layer: CAShapeLayer = CAShapeLayer()
        internal var bezier_path: UIBezierPath = UIBezierPath()
        
        internal func clear() {
            shape_layer.removeFromSuperlayer()
            shape_layer = CAShapeLayer()
        }
        
        internal func set(chart:      Chart,
                          frame:      CGRect,
                          plusColor:  UIColor,
                          minusColor: UIColor) {
            let sign    = chart.marketChange.raw.sign
            let color   = sign == .minus ? minusColor : plusColor
            bezier_path = UIBezierPath()
            shape_layer = CAShapeLayer()
            
            bezier_path.move(to: .init(x: .zero,
                                       y: y_point(chart: chart, frame: frame)))
            
            bezier_path.addLine(to: .init(x: frame.width,
                                          y: y_point(chart: chart, frame: frame)))
        
            shape_layer.path        = bezier_path.cgPath
            shape_layer.lineWidth   = CGFloat.init(1.5)
            shape_layer.strokeColor = color.cgColor
            shape_layer.lineDashPattern = [3.0, 2.0]
        }
        
        fileprivate func y_point(chart: Chart, frame: CGRect) -> CGFloat {
            let prev = chart.marketPreviousClose.raw
            let max0 = chart.indicators.high.max
            let min0 = chart.indicators.low.min
            
            let max1 = prev > max0 ? prev : max0
            let min1 = prev < min0 ? prev : min0
            
            let r0 = (max1 - min1)
            let r1 = (max1 - prev)
            let p0 = (r1 / r0) * 1.0
            let y  = CGFloat(p0 * frame.height)
            
            return max(1, min(y-1, y))
        }
    }
}
