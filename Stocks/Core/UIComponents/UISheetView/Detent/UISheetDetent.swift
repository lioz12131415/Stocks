//
//  UISheetDetent.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

final class UISheetDetent: Hashable {
    
    private(set) var type: `Type`
    private(set) var extra: CGFloat = .zero
    private(set) var point: CGFloat = .zero
    
    internal var y: CGFloat {
        return point-extra
    }
    
    private init(_ type: `Type`, extra: CGFloat) {
        self.type  = type
        self.extra = extra
    }
    
    internal func update(point: CGFloat) {
        self.point = point
    }
    
    internal func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
    
    internal static func == (lhs: UISheetDetent, rhs: UISheetDetent) -> Bool {
        return lhs.type == rhs.type
    }
    
    enum `Type`: Hashable {
        case large
        case small
        case medium
    }
}

extension UISheetDetent {
    internal static func large() -> UISheetDetent {
        return UISheetDetent(.large, extra: .zero)
    }
    
    internal static func medium() -> UISheetDetent {
        return UISheetDetent(.medium, extra: .zero)
    }
    
    internal static func small(_ extra: CGFloat = .zero) -> UISheetDetent {
        return UISheetDetent(.small, extra: extra)
    }
}

extension UISheetDetent: CustomStringConvertible {
    internal var description: String {
        return "\(type)"
    }
}
