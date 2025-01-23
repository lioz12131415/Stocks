//
//  URLRequest+Extensions.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
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

