//
//  CoreDataTransformer.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

@objc(CoreDataTransformer)
public final class CoreDataTransformer: NSSecureUnarchiveFromDataTransformer {

    public override static var allowedTopLevelClasses: [AnyClass] {
        return [OrderedLookups.self ,OrderedQuotes.self, OrderedCharts.self, NSData.self, NSNull.self, NSSet.self, NSArray.self, NSNumber.self, NSValue.self, NSString.self, NSDictionary.self]
    }
    
    public static func register() {
        let rawValue = String(describing: CoreDataTransformer.self)
        let name     = NSValueTransformerName(rawValue: rawValue)
        ValueTransformer.setValueTransformer(CoreDataTransformer(), forName: name)
    }
}

