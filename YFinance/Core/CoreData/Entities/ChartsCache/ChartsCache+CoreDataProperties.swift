//
//  ChartsCache+CoreDataProperties.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//
//

import CoreData
import Foundation

extension ChartsCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChartsCache> {
        return NSFetchRequest<ChartsCache>(entityName: "ChartsCache")
    }

    @NSManaged public var dictionary: [String: OrderedCharts]?
}

extension ChartsCache : Identifiable {

}


