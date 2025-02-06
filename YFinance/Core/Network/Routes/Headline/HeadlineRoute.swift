//
//  HeadlineRoute.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

final
public class HeadlineRoute {
    
    private(set) public var symbol: String = .empty
    
    public init() {
        /* * * * * */
    }
    
    @discardableResult
    public func symbol(_ value: String) -> Self {
        self.symbol = value
        return self
    }
    
    public func path() -> String {
        return """
        headline?s=\(symbol)&region=US&lang=en-US&format=json
        """
    }
}


