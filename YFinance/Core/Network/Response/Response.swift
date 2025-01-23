//
//  Response.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Networking
import Foundation

public struct Response<R: Responseable>: Codable {
    
    internal(set) public var data: JSON
    internal(set) public var meta: JSON
    
    public init() {
        self.data = .null
        self.meta = R.meta()
    }
    
    public init(from decoder: Decoder) throws {
        self.meta = R.meta()
        self.data = R.rewrite(from: decoder)
    }
}

extension Response: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    public var description: String {
        return JSON(["data": data,
                     "meta": meta,]).description
    }

    public var customMirror: Mirror {
        return Mirror(self, children: [:])
    }
    
    public var debugDescription: String {
        return JSON(["data": data,
                     "meta": meta,]).debugDescription
    }
}

extension Response {
    public static var empty: Response<R> {
        return Response<R>()
    }
}
