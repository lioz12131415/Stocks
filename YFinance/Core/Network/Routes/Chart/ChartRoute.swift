//
//  ChartRoute.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

final
public class ChartRoute {
    
    public typealias Range       = Chart.Range
    public typealias Granularity = Chart.Granularity

    private(set) public var symbol:      String      = .empty
    private(set) public var range:       Range       = .unowned
    private(set) public var granularity: Granularity = .unowned
    
    public init() {
        /* * * * * */
    }
    
    @discardableResult
    public func range(_ value: Range) -> Self {
        self.range = value
        return self
    }
    
    @discardableResult
    public func symbol(_ value: String) -> Self {
        self.symbol = value
        return self
    }
    
    @discardableResult
    public func granularity(_ value: Granularity) -> Self {
        self.granularity = value
        return self
    }

    public func path() -> String {
        return """
        chart/\(symbol)?interval=\(granularity.rawValue)&range=\(range.rawValue)
        """
    }
}


