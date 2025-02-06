//
//  Headline.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public struct Headline: Headlineable, Buildable {
    
    private(set) public var link:        String = .empty
    private(set) public var title:       String = .empty
    private(set) public var dateCreated: String = .empty
    private(set) public var description: String = .empty
    
    public init() {
        /* * * */
    }
    
    public init(from json: JSON) {
        self.update(from: json)
    }
    
    @discardableResult
    public mutating func update(from json: JSON) -> Headline {
        return builder
            .set(json["link"].stringValue,        for: \.link)
            .set(json["title"].stringValue,       for: \.title)
            .set(json["dateCreated"].stringValue, for: \.dateCreated)
            .set(json["description"].stringValue, for: \.description)
            .build(into: &self)
    }
}

