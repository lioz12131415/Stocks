//
//  NSMapTable+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
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

extension NSMapTable {
    @objc func forEach(_ body: (Any?) -> Void) {
        objectEnumerator()?.allObjects.forEach {
            body($0)
        }
    }
}
