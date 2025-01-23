//
//  Crumb+CoreDataProperties.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//
//

import CoreData
import Foundation

extension Crumb {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crumb> {
        return NSFetchRequest<Crumb>(entityName: "Crumb")
    }
    @NSManaged public var key:         String
    @NSManaged public var name:        String
    @NSManaged public var domain:      String
    @NSManaged public var expiresDate: Date?
}

extension Crumb: Identifiable {

}
