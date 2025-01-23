//
//  NSMapTable+Extensions.swift
//  Structures
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


