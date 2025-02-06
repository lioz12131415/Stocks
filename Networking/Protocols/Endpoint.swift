//
//  Endpoint.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
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

