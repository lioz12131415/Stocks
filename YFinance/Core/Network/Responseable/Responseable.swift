//
//  Responseable.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public protocol Responseable {
    static func rewrite(from decoder: Decoder) -> JSON
}

extension Responseable {
    public static func meta() -> JSON {
        return JSON([
            "authors": JSON([
                "lioz balki"
            ]),
            "copyright": "Copyright © Lioz Balki. All rights reserved."
        ])
    }
}
