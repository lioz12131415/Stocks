//
//  NetworkService.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
//

import Foundation

open class NetworkService<E: Endpoint> {
    
    public init() {
        /* * * * * */
    }
    
    final public func session(_ request: Request<E>?, session: URLSession = .shared) -> Session<E> {
        return Session(request, session)
    }
    
    final public func request(_ endpoint: E, body: Dictionary<String, Any>? = nil) -> Request<E>? {
        return Request(endpoint, body: body)
    }
}

extension NetworkService {
    @discardableResult
    public func get(_ session: Session<E>, _ type: XML.Type) async throws -> XML {
        session.request?.method(.get)
        return try await session.request(type)
    }
    @discardableResult
    public func put(_ session: Session<E>, _ type: XML.Type) async throws -> XML {
        session.request?.method(.put)
        return try await session.request(type)
    }
    @discardableResult
    public func post(_ session: Session<E>, _ type: XML.Type) async throws -> XML {
        session.request?.method(.post)
        return try await session.request(type)
    }
    @discardableResult
    public func delete(_ session: Session<E>, _ type: XML.Type) async throws -> XML {
        session.request?.method(.delete)
        return try await session.request(type)
    }
}

extension NetworkService {
    @discardableResult
    public func get(_ session: Session<E>) async throws -> (Data, HTTPURLResponse) {
        session.request?.method(.get)
        return try await session.request()
    }
    @discardableResult
    public func put(_ session: Session<E>) async throws -> (Data, HTTPURLResponse) {
        session.request?.method(.put)
        return try await session.request()
    }
    @discardableResult
    public func post(_ session: Session<E>) async throws -> (Data, HTTPURLResponse) {
        session.request?.method(.post)
        return try await session.request()
    }
    @discardableResult
    public func delete(_ session: Session<E>) async throws -> (Data, HTTPURLResponse) {
        session.request?.method(.delete)
        return try await session.request()
    }
}

extension NetworkService {
    @discardableResult
    public func get<T: Decodable>(_ session: Session<E>, _ type: T.Type) async throws -> T {
        session.request?.method(.get)
        return try await session.request(type)
    }
    @discardableResult
    public func put<T: Decodable>(_ session: Session<E>, _ type: T.Type) async throws -> T {
        session.request?.method(.put)
        return try await session.request(type)
    }
    @discardableResult
    public func post<T: Decodable>(_ session: Session<E>, _ type: T.Type) async throws -> T {
        session.request?.method(.post)
        return try await session.request(type)
    }
    @discardableResult
    public func delete<T: Decodable>(_ session: Session<E>, _ type: T.Type) async throws -> T {
        session.request?.method(.delete)
        return try await session.request(type)
    }
}

extension NetworkService {
    @discardableResult
    public func get(_ session: Session<E>, _ type: HTTPDecoder.Type) async throws -> Decoder {
        session.request?.method(.get)
        return try await session.request(type)
    }
    @discardableResult
    public func put(_ session: Session<E>, _ type: HTTPDecoder.Type) async throws -> Decoder {
        session.request?.method(.put)
        return try await session.request(type)
    }
    @discardableResult
    public func post(_ session: Session<E>, _ type: HTTPDecoder.Type) async throws -> Decoder {
        session.request?.method(.post)
        return try await session.request(type)
    }
    @discardableResult
    public func delete(_ session: Session<E>, _ type: HTTPDecoder.Type) async throws -> Decoder {
        session.request?.method(.delete)
        return try await session.request(type)
    }
}
