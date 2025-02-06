//
//  Market.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public protocol Market: Codable {
    var raw: Double { get }
    var fmt: String { get }
    var sgn: String { get }
    
    init(from value: Double)
    init(from json: JSON)
}

extension Market {
    public static var empty: Self {
        return Self(from: 0.0)
    }
}


 
