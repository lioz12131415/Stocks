//
//  Session.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
//

import Foundation

public struct Session<E: Endpoint> {
    
    private(set) var session:  URLSession
    private(set) var request:  Request<E>?
    
    internal init(_ request: Request<E>?, _ session: URLSession = .shared) {
        self.session  = session
        self.request  = request
    }
    
    internal func request() async throws -> (Data, HTTPURLResponse) {
        guard let request = request else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        do {
            let (data, response) = try await session.data(for: request.urlRequest)
            return (data, try response.httpValue())
        } catch let error as NSError {
            if error.code == NSURLErrorCancelled {
                throw HTTPError.cancelled
            } else {
                throw HTTPError.invalid(.init(error: error))
            }
        }
    }
    
    internal func request(_ type: XML.Type) async throws -> XML {
        guard let request = request else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        do {
            let response  = try await session.data(for: request.urlRequest)
            let validated = try await session.validate(response.0, response.1)
            return HTTPDecoder.decode(xml: validated.0)
        } catch let error as NSError {
            if error.code == NSURLErrorCancelled {
                throw HTTPError.cancelled
            } else {
                throw HTTPError.invalid(.init(error: error))
            }
        }
    }
    
    internal func request(_ type: HTTPDecoder.Type) async throws -> Decoder {
        guard let request = request else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        do {
            let response  = try await session.data(for: request.urlRequest)
            let validated = try await session.validate(response.0, response.1)
            return try HTTPDecoder.decode(validated.0)
        } catch let error as NSError {
            if error.code == NSURLErrorCancelled {
                throw HTTPError.cancelled
            } else {
                throw HTTPError.invalid(.init(error: error))
            }
        }
    }
    
    internal func request<T: Decodable>(_ type: T.Type) async throws -> T {
        guard let request = request else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        do {
            let response  = try await session.data(for: request.urlRequest)
            let validated = try await session.validate(response.0, response.1)
            return try HTTPDecoder.decode(validated.0)
        } catch let error as NSError {
            if error.code == NSURLErrorCancelled {
                throw HTTPError.cancelled
            } else {
                throw HTTPError.invalid(.init(error: error))
            }
        }
    }
}

extension URLSession {
    fileprivate func validate(_ data: Data, _ response: URLResponse) async throws -> (Data, HTTPURLResponse) {
        guard let response = response as? HTTPURLResponse else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        guard response.isValidStatusCode else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        return (data, response)
    }
}

extension URLResponse {
    internal func httpValue() throws -> HTTPURLResponse {
        guard let response = self as? HTTPURLResponse else {
            throw HTTPError.invalid(.init(message: "TODO"))
        }
        return response
    }
}
