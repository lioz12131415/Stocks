//
//  Components.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
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
