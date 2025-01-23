//
//  Request.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final public class Request<E: Endpoint> {
    
    private(set) var urlRequest: URLRequest
    
    internal init?(_ endpoint: E, body: Dictionary<String, Any>?) {
        guard let url = endpoint.url else {
            return nil
        }
        self.urlRequest = URLRequest(url: url, body: body)
        self.header(field: .accept,      .json)
        self.header(field: .contentType, .json)
    }
    
    @discardableResult
    internal func method(_ method: HTTPMethod) -> Self {
        self.urlRequest.httpMethod = method.rawValue
        return self
    }
    
    @discardableResult
    public func header<F: HTTPHeaderField>(field: F, _ value: F.Value) -> Self {
        self.urlRequest.addValue(value.raw, forHTTPHeaderField: field.raw)
        return self
    }

    public func addValue(_ value: String, forHTTPHeaderField field: String) {
        self.urlRequest.addValue(value, forHTTPHeaderField: field)
    }
}


