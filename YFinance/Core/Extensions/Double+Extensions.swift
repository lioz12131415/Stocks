//
//  Double+Extensions.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import Foundation

extension Double {
    public func sgn(defaultZero: Bool = true) -> String {
        return formatted(signed: true, percent: false, defaultZero: defaultZero)
    }
}

extension Double {
    public func spc(defaultZero: Bool = true) -> String {
        return formatted(signed: true, percent: true, defaultZero: defaultZero)
    }
}

extension Double {
    public func pct(defaultZero: Bool = true) -> String {
        return formatted(signed: self < 0, percent: true, defaultZero: defaultZero)
    }
}

extension Double {
    public func fmt(defaultZero: Bool = true) -> String {
        return formatted(signed: self < 0, percent: false, defaultZero: defaultZero)
    }
}

extension Double {
    public func formatted(signed: Bool, percent: Bool, defaultZero: Bool = true) -> String {
        if self == 0.0 && defaultZero {
            return signed ? "+0.00" + (percent ? "%" : "") : "0.00" + (percent ? "%" : "")
        }
        
        let absValue = abs(self)
        let maximumDigits: Int
        let minimumDigits: Int
        
        if absValue < 1.0 {
            maximumDigits = 3
            minimumDigits = 3
        } else {
            maximumDigits = 2
            minimumDigits = 2
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle           = .decimal
        formatter.roundingMode          = .halfUp
        formatter.groupingSeparator     = .init(",")
        formatter.maximumFractionDigits = maximumDigits
        formatter.minimumFractionDigits = minimumDigits
        
        guard let string = formatter.string(from: NSNumber(value: absValue)) else {
            return .empty
        }
        
        let percentSuffix = percent ? "%" : ""
        var signPrefix = ""
        if signed {
            signPrefix = self >= 0 ? "+" : "-"
        } else if self < 0 {
            signPrefix = "-"
        }
        
        return "\(signPrefix)\(string)\(percentSuffix)"
    }
}


