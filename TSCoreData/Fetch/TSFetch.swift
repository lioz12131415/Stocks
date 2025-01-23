//
//  TSFetch.swift
//  TSCoreData
//
//  Created by ליעוז בלקי on 10/12/2024.
//

import Foundation

public protocol TSFetch: TSPerform {
    
}

extension TSFetch {
    public static var count: Int {
        return request.count
    }
    
    public static var all: [Self] {
        return request.all
    }
    
    public static var last: Self? {
        return request.last
    }
    
    public static var first: Self? {
        return request.first
    }
    
    public static var request: TSRequest<Self> {
        return TSRequest<Self>()
    }
}
