//
//  ChartsCache.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import SecureData
import Foundation

final
public class ChartsCache: SecureMap<String, Chart> {
    
    private(set) var range:       Chart.Range
    private(set) var granularity: Chart.Granularity
    
    internal init(range r: Chart.Range, granularity g: Chart.Granularity) {
        self.range       = r
        self.granularity = g
        super.init("cache.secure.charts.\(r.rawValue).\(g.rawValue)")
    }
}
