//
//  Lookup.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public struct Lookup: Profile, Buildable {

    public var symbol:    String = .empty
    public var exchange:  String = .empty
    public var quoteType: String = .empty
    public var shortName: String = .empty
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }
    
    @discardableResult
    public mutating func update(from json: JSON) -> Lookup {
        return builder
            .set(json["symbol"].stringValue,    for: \.symbol)
            .set(json["exchange"].stringValue,  for: \.exchange)
            .set(json["quoteType"].stringValue, for: \.quoteType)
            .set(json["shortName"].stringValue, for: \.shortName)
            .build(into: &self)
    }
}
