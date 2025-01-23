//
//  Endpoint.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public protocol Endpoint: Components {
    var url: URL? { get }
}

extension Endpoint {
    public var url: URL? {
        guard !host.contains(scheme: "http") && !host.contains(scheme: "https") else {
            return "\(host)\(path)".convertToUrl
        }
        return "\(scheme)\(host)\(path)".convertToUrl
    }
}

