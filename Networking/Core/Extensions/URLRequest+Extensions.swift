//
//  URLRequest+Extensions.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
//

import Foundation

extension URLRequest {
    internal init(url: URL, body: Dictionary<String, Any>?) {
        self.init(url: url)
        
        if let body = body {
            self.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
    }
}

