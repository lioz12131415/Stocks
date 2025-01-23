//
//  HTTPCookies.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public class HTTPCookies {
    
    public typealias Element = HTTPCookie
    public typealias Storage = HTTPCookieStorage
    
    private(set) public static var shared: HTTPCookies = HTTPCookies()

    fileprivate var storage:  Storage   { Storage.shared }
    fileprivate var elements: [Element] { storage.cookies ?? [] }
    
    public var count: Int {
        return elements.count
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var last: Element? {
        return elements.last
    }
    
    public var first: Element? {
        return elements.first
    }
    
    public func removeAll() {
        elements.forEach { storage.deleteCookie($0) }
    }
    
    public func remove(_ cookie: Element?) {
        if let cookie = cookie { storage.deleteCookie(cookie) }
    }
    
    public func remove(_ predicate: (Element) -> Bool) {
        remove(first(where: predicate))
    }
    
    public func first(where predicate: (Element) -> Bool) -> Element? {
        elements.first(where: predicate)
    }
}

