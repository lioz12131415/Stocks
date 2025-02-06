//
//  JSON+Equatable.swift
//  Networking
//
//  Created by ליעוז בלקי on 30/12/2024.
//

import Foundation

extension JSON: Equatable {
    public func hash(into hasher: inout Hasher) {
        guard let object = object as? any Hashable else {
            return
        }
        hasher.combine(object)
    }
}
