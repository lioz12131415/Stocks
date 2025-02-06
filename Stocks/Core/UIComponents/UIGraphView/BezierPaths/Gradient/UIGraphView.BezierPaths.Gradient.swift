//
//  UIGraphView.BezierPaths.Gradient.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

extension UIGraphView.BezierPaths {
    class Gradient {
        
        internal var bezier_path:    UIBezierPath    = UIBezierPath()
        internal var gradient_mask:  CAShapeLayer    = CAShapeLayer()
        internal var gradient_layer: CAGradientLayer = CAGradientLayer()
        
        internal func clear() {
            gradient_layer.removeFromSuperlayer()
            gradient_mask.removeFromSuperlayer()
            gradient_layer = CAGradientLayer()
            gradient_mask  = CAShapeLayer()
        }
        
        internal func set(chart:      Chart,
                          frame:      CGRect,
                          layer:      CALayer,
                          plusColor:  UIColor,
                          minusColor: UIColor,
                          bezierPath: UIBezierPath) {
            guard let timestamp = chart.timestamp.all.last else {
                return
            }
            
            let end        = chart.tradingPeriod.regular.end
            let sign       = chart.marketChange.raw.sign
            let start      = chart.tradingPeriod.regular.start
            let percentage = start > timestamp ? 1.0 : Double(timestamp - start) / Double(end - start)
            
            bezier_path    = bezierPath
            gradient_mask  = CAShapeLayer()
            gradient_layer = CAGradientLayer()
            
            bezier_path.addLine(to: CGPoint(x: (frame.width * percentage), y: frame.height))
            bezier_path.addLine(to: CGPoint(x: .zero, y: frame.height))
            bezier_path.close()
        
            gradient_mask.contentsScale = UIScreen.main.scale
            gradient_mask.path = bezier_path.cgPath
            
            gradient_layer.mask          = gradient_mask
            gradient_layer.frame         = layer.bounds
            gradient_layer.colors        = sign == .minus ? color(minusColor) : color(plusColor)
            gradient_layer.contentsScale = UIScreen.main.scale
        }
    }
}

extension UIGraphView.BezierPaths.Gradient {
    internal func color(_ color: UIColor) -> [CGColor] {
        return stride(from: 0.60, to: 0.00, by: -0.05).map {
            color.withAlphaComponent(CGFloat($0)).cgColor
        }
    }
}
