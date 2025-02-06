//
//  JSON+Lookup.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

extension JSON {
    public struct Lookup: Responseable {
        public static func rewrite(from decoder: Decoder) -> JSON {
            let json      = try? JSON(from: decoder)
            let result    = json?["finance"]["result"].arrayValue ?? []
            let documents = result.first?["documents"].arrayValue ?? []
            return JSON(documents.map { JSON($0.profile()) })
        }
    }
}
