//
//  HTTPHeaderField.swift
//  Networking
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

public protocol HTTPHeaderField {
    associatedtype Value: HTTPHeaderValue
    var raw: String { get }
}

extension HTTPHeaderField where Self == AcceptHeaderField {
    public static var accept: AcceptHeaderField {
        return AcceptHeaderField()
    }
}

extension HTTPHeaderField where Self == UserAgentHeaderField {
    public static var userAgent: UserAgentHeaderField {
        return UserAgentHeaderField()
    }
}

extension HTTPHeaderField where Self == ContentTypeHeaderField {
    public static var contentType: ContentTypeHeaderField {
        return ContentTypeHeaderField()
    }
}

