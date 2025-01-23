//
//  HTTPURLResponse+Extensions.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension HTTPURLResponse {
    internal var isValidStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
