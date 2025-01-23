//
//  LookupsCache+CoreDataClass.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import TSCoreData
import Foundation

@objc(LookupsCache)
public class LookupsCache: NSManagedObject, TSManagedObject {
    
    public static var get: LookupsCache = {
        return first ?? new
    }()
    
    public override var description: String {
        return elements.description
    }
    
    public override var debugDescription: String {
        return elements.debugDescription
    }
    
    public static var context: NSManagedObjectContext {
        return CoreDataManeger.lookupsContext
    }
        
    internal var elements: OrderedLookups {
        get { ts.ordered ?? .empty }
        set { ts.ordered = newValue }
    }
        
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        if ts.ordered == nil { ts.ordered = .empty }
    }
}
