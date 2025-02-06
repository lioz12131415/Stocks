//
//  XML+Headlines.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking

extension XML {
    public struct Headlines: Responseable {
        public static func rewrite(from decoder: Decoder) -> JSON {
            fatalError("TODO")
        }
    }
}

extension XML {
    internal func headline() -> JSON {
        return [
            "link":        JSON(first("link").stringValue),
            "title":       JSON(first("title").stringValue),
            "dateCreated": JSON(first("pubDate").stringValue),
            "description": JSON(first("description").stringValue),
        ]
    }
}

extension XML {
    public func headlines(_ symbol: String) -> JSON {
        return [
            "link":        JSON(self[0].first("link").stringValue),
            "title":       JSON(self[0].first("title").stringValue),
            "dateCreated": JSON(self[0].first("lastBuildDate").stringValue),
            
            "symbol":   JSON(symbol),
            "elements": JSON(self[0].select("item").map { $0.headline() })
        ]
    }
}
