//
//  ChartSpark+Associated.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

fileprivate var initialKey: UInt8 = 0

extension NSObject {
    internal func spark(for charts: [Chart]) -> ChartsSpark {
        let spark = withUnsafePointer(to: &initialKey) { [weak self] in
            guard let self else {
                return ChartsSpark()
            }
            if let objc = objc_getAssociatedObject(self, $0) {
                return objc as! ChartsSpark
            }
            else {
                objc_setAssociatedObject(self, $0, ChartsSpark(), .OBJC_ASSOCIATION_RETAIN)
            }
            return objc_getAssociatedObject(self, $0) as! ChartsSpark
        }
        return spark.prepare(charts)
    }
}
