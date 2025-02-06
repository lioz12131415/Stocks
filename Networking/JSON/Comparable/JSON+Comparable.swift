//
//  JSON+Comparable.swift
//  Networking
//
//  Created by ליעוז בלקי on 13/01/2025.
//

import Foundation

//extension JSON: Comparable {
//    public static func <(lhs: JSON, rhs: JSON) -> Bool {
//        guard let rhs = rhs.object,
//              let bool = lhs.object?.isLess(than: rhs) else {
//            return false
//        }
//        return bool
//    }
////    
////    public static func >(lhs: JSON, rhs: JSON) -> Bool {
////        guard let bool = lhs.object?.isLess(than: rhs.object) else {
////            return true
////        }
////        return !bool
////    }
//}

//extension Array where Element == NSNumber {
//    internal func min() -> NSNumber {
//        guard !isEmpty else {
//            return 0
//        }
//        return reduce(self[0]) { $0.compare($1) == .orderedAscending ? $0 : $1 }
//    }
//}
//
//extension Array where Element == NSNumber {
//    internal func max() -> NSNumber {
//        guard !isEmpty else {
//            return 0
//        }
//        return reduce(self[0]) { $0.compare($1) == .orderedDescending ? $0 : $1 }
//    }
//}
