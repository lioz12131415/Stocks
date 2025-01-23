//
//  QuoteStream+Associated.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

fileprivate var initialKey: UInt8 = 0

extension NSObject {
    internal func stream(for quote: Quote) -> QuoteStream {
        let key     = pointer+"\(quote.symbol)"
        let streams = map(to: &initialKey)
        
        if let stream = streams[key] as? QuoteStream {
            return stream
        }
        else {
            streams[key] = QuoteStream(quote)
        }
        return streams[key] as! QuoteStream
    }
}

