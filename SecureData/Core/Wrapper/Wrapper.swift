//
//  Wrapper.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation 

@dynamicMemberLookup
struct Wrapper<O: Securable> {
    
    internal var obj: O
    internal var key: String
    internal var que: DispatchQueue
    
    internal init(_ key: String) {
        self.key = key
        self.obj = .load(key: key) ?? .init()
        self.que = .init(label: "secure.wrapper.dispatch")
    }
    
    internal func save() {
        FileManager.default.write(encrypt(), to: key)
    }
    
    internal func encrypt() -> Data? {
        return sync { obj.encrypt(with: key) }
    }
    
    internal subscript<V>(dynamicMember keyPath: KeyPath<O, V>) -> V {
        get { sync { obj[keyPath: keyPath] } }
    }
    
    internal subscript<V>(dynamicMember keyPath: KeyPath<O, V?>) -> V? {
        get { sync { obj[keyPath: keyPath] } }
    }
    
    internal subscript<V>(dynamicMember keyPath: WritableKeyPath<O, V>) -> V {
        get { sync { obj[keyPath: keyPath] } }
        set { sync { obj[keyPath: keyPath] = newValue } }
    }
    
    internal subscript<V>(dynamicMember keyPath: WritableKeyPath<O, V?>) -> V? {
        get { sync { obj[keyPath: keyPath] } }
        set { sync { obj[keyPath: keyPath] = newValue } }
    }
}



