//
//  Chart+Range.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

extension Chart {
    public enum Range: String, Codable {
        case d1      = "1d"
        case d5      = "5d"
        case y1      = "1y"
        case y2      = "2y"
        case y5      = "5y"
        case y10     = "10y"
        case ytd     = "ytd"
        case mo1     = "1mo"
        case mo3     = "3mo"
        case mo6     = "6mo"
        case max     = "max"
        case unowned = "unowned"
        
        public init(from json: JSON) {
            self = .init(rawValue: json.stringValue) ?? .unowned
        }
    }
}
