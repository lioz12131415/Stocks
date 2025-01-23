//
//  QuotesCache+CoreDataProperties.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//
//

import CoreData
import Foundation

extension QuotesCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuotesCache> {
        return NSFetchRequest<QuotesCache>(entityName: "QuotesCache")
    }
    
    @NSManaged public var ordered: OrderedQuotes?
}

extension QuotesCache : Identifiable {

}
