//
//  Chart+Granularity.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

extension Chart {
    public enum Granularity: String, Codable {
        case m1  = "1m"
        case m2  = "2m"
        case m5  = "5m"
        case m15 = "15m"
        case m30 = "30m"
        
        case h1      = "1h"
        case d1      = "1d"
        case wk1     = "1wk"
        case mo1     = "1mo"
        case mo3     = "3mo"
        case unowned = "unowned"
        
        public init(from json: JSON) {
            self = .init(rawValue: json.stringValue) ?? .unowned
        }
    }
}

extension Chart.Granularity {
    public var seconds: Int {
        switch self {
            case .m1:  return 60 * 1
            case .m2:  return 60 * 2
            case .m5:  return 60 * 5
            case .m15: return 60 * 15
            case .m30: return 60 * 30
        
            case .h1:  return (60 * 60) * 1
            case .d1:  return (60 * 60) * 24
            case .wk1: return (60 * 60) * (24 * 7)
            case .mo1: return (60 * 60) * (24 * 30)
            case .mo3: return (60 * 60) * (24 * 30) * 3
            
        default:
            return .zero
        }
    }
}
