//
//  JSON+Equatable.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
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
