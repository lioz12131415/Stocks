//
//  HTTPURLResponse+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
//

import Foundation

extension HTTPURLResponse {
    internal var isValidStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
