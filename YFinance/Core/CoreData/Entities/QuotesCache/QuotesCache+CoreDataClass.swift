//
//  QuotesCache+CoreDataClass.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//
//

import CoreData
import TSCoreData
import Foundation

@objc(QuotesCache)
public class QuotesCache: NSManagedObject, TSManagedObject {
    
    public static var get: QuotesCache = {
        return first ?? new
    }()
    
    public override var description: String {
        return elements.description
    }
    
    public override var debugDescription: String {
        return elements.debugDescription
    }
    
    public static var context: NSManagedObjectContext {
        return CoreDataManeger.persistentContainer.viewContext
    }
        
    internal var elements: OrderedQuotes {
        get { ts.ordered ?? .empty }
        set { ts.ordered = newValue }
    }

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        if ts.ordered == nil { ts.ordered = .empty }
    }
}
