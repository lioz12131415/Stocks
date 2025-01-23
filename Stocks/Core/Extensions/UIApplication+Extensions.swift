//
//  UIApplication+Extensions.swift
//  Stocks
//
//  Created by Lioz Balki on 1/01/1970.
//

import UIKit
import Foundation

extension UIApplication {
    internal static func open(_ url: String) {
        guard let url = url.convertToUrl else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url , options: [:])
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

extension UIApplication {
    var keyWindow: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
