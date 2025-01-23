//
//  LookupsCache+CoreDataProperties.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

extension LookupsCache {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LookupsCache> {
        return NSFetchRequest<LookupsCache>(entityName: "LookupsCache")
    }
    @NSManaged public var ordered: OrderedLookups?
}

extension LookupsCache : Identifiable {

}
