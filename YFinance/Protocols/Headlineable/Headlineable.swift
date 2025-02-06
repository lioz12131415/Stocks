//
//  Headlineable.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public protocol Headlineable: Codable {
    var link:        String { get }
    var title:       String { get }
    var dateCreated: String { get }
    
    init(from json: JSON)
}

