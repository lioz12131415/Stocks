//
//  UIGraphView.BezierPaths.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import YFinance
import Foundation

extension UIGraphView {
    final class BezierPaths {
        
        internal var lines:    Lines    = .init()
        internal var gradient: Gradient = .init()
        internal var dashLine: DashLine = .init()
        
        internal func start(chart:          Chart,
                            frame:          CGRect,
                            layer:          CALayer,
                            plusColor:      UIColor,
                            minusColor:     UIColor,
                            dashPlusColor:  UIColor,
                            dashMinusColor: UIColor,
                            callback: @escaping(_ lines:    UIGraphView.BezierPaths.Lines,
                                                _ gradient: UIGraphView.BezierPaths.Gradient,
                                                _ dashLine: UIGraphView.BezierPaths.DashLine) -> Void) {

            lines.clear()
            dashLine.clear()
            gradient.clear()
            
            let bezier_path = bezier_path(chart, frame: frame)
            
            lines.set(chart:      chart,
                      frame:      frame,
                      plusColor:  plusColor,
                      minusColor: minusColor,
                      bezierPath: UIBezierPath(cgPath: bezier_path.cgPath))
            
            dashLine.set(chart:      chart,
                         frame:      frame,
                         plusColor:  dashPlusColor,
                         minusColor: dashMinusColor)

            gradient.set(chart:      chart,
                         frame:      frame,
                         layer:      layer,
                         plusColor:  plusColor,
                         minusColor: minusColor,
                         bezierPath: UIBezierPath(cgPath: bezier_path.cgPath))
            
            callback(lines, gradient, dashLine)
        }
        
        fileprivate func bezier_path(_ chart: Chart, frame: CGRect) -> UIBezierPath {
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: .zero,
                                  y: cg_point(for: .zero, in: chart, frame: frame).y))
            
            guard chart.indicators.close.all.count > .zero else {
                return path
            }
            
            
            for i in 1..<chart.indicators.close.all.count {
                let next = cg_point(for: i, in: chart, frame: frame)
                path.addLine(to: CGPoint(x: next.x, y: next.y))
            }
            return path
        }
        
        fileprivate func cg_point(for index: Int, in chart: Chart, frame: CGRect) -> CGPoint {
            guard let last = chart.timestamp.all.last else {
                return .zero
            }
            let end     = chart.tradingPeriod.regular.end
            let start   = chart.tradingPeriod.regular.start
            let percent = start > last ? 1.0 : Double(last - start) / Double(end - start)
            
            let prev    = chart.marketPreviousClose.raw
            let max0    = chart.indicators.high.max
            let min0    = chart.indicators.low.min
            
            let max1   = prev > max0 ? prev : max0
            let min1   = prev < min0 ? prev : min0
        
            let point  = chart.indicators.close.all[index]
            let spaceX = (frame.width * percent) / CGFloat(chart.indicators.close.all.count-1)

            let r0 = (max1 - min1)
            let r1 = (max1 - point)
            let p0 = (r1 / r0)

            let x = CGFloat(index)*spaceX
            let y = CGFloat(p0)*frame.height
            
            return .init(x: x, y: y)
        }
    }
}

extension UIGraphView.BezierPaths {
    static var empty: UIGraphView.BezierPaths {
        return UIGraphView.BezierPaths()
    }
}
