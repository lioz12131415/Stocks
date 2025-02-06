//
//  LookupsCache.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import SecureData
import Foundation

final
public class LookupsCache: SecureMap<String, Lookup> {
    
    internal init() {
        super.init("cache.secure.lookups")
    }
}
