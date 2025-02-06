//
//  Dictionary+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension Dictionary {
    internal subscript(safe key: Key?) -> Value? {
        guard let key = key else {
            return nil
        }
        return self[key]
    }
}
