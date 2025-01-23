//
//  Ticker.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public protocol Ticker: Codable {
    var symbol: String { get }
    init(from json: JSON)
}

extension Ticker {
    public var quoteJSON: JSON {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONDecoder().decode(JSON.self, from: data) else {
            return .null
        }
        return json
    }
    
    public var quoteValue: Quote {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONDecoder().decode(JSON.self, from: data) else {
            return Quote()
        }
        return Quote(from: json)
    }
    
    public var lookupValue: Lookup {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONDecoder().decode(JSON.self, from: data) else {
            return Lookup()
        }
        return Lookup(from: json)
    }
    
    public func chartValue(range: Chart.Range, granularity: Chart.Granularity) -> Chart {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONDecoder().decode(JSON.self, from: data) else {
            return Chart()
        }
        var chart         = Chart(from: json)
        chart.range       = range
        chart.granularity = granularity
        return chart
    }
}
