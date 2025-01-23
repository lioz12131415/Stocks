//
//  Components.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public protocol Components {
    var path:   String { get }
    var host:   String { get }
    var scheme: String { get }
}

extension Components {
    public var scheme: String {
        return "https://"
    }
}
