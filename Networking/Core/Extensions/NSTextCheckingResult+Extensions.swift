//
//  NSTextCheckingResult+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension NSTextCheckingResult {
    internal func tagValue(_ xml: String) -> XML.Tag? {
        guard let tag     = Range(range(at: 1), in: xml),
              let content = Range(range(at: 2), in: xml) else {
            return nil
        }
        let key   = String(xml[tag])
        let value = String(xml[content])
        return XML.Tag(key: key, value: value)
    }
}
