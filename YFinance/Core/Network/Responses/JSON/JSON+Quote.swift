//
//  JSON+Quote.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

extension JSON {
    public struct Quote: Responseable {
        public static func rewrite(from decoder: Decoder) -> JSON {
            let json      = try? JSON(from: decoder)
            let result = json?["quoteResponse"]["result"].arrayValue ?? []
            return JSON(result.map { $0.summary() })
        }
    }
}
