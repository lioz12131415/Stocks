//
//  NSMapTable+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension NSMapTable {
    @objc var keys: [String] {
        return keyEnumerator().compactMap {
            $0 as? String
        }
    }
    
    @objc var values: [Any] {
        return objectEnumerator()?.allObjects ?? []
    }
}
