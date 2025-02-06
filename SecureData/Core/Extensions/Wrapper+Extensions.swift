//
//  Wrapper+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Wrapper {
    @discardableResult
    internal func sync<V>(_ block: () -> V) -> V {
        var value: V!
        que.sync {
            value = block()
        }
        return value
    }
}

extension Wrapper {
    @discardableResult
    internal mutating func sync<V>(_ block: (inout O) -> V) -> V {
        var value: V!
        que.sync {
            value = block(&obj)
        }
        return value
    }
}
