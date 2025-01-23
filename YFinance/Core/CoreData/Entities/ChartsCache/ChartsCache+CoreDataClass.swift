//
//  ChartsCache+CoreDataClass.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//
//

import CoreData
import TSCoreData
import Foundation

@objc(ChartsCache)
public class ChartsCache: NSManagedObject, TSManagedObject {
    
    public typealias Range       = Chart.Range
    public typealias Granularity = Chart.Granularity

    public static var get: ChartsCache = {
        return first ?? new
    }()
    
    internal var elements: [String: OrderedCharts] {
        get { ts.dictionary ?? [:] }
        set { ts.dictionary = newValue }
    }
    
    public static var context: NSManagedObjectContext {
        return CoreDataManeger.chartsContext
    }
    
    public subscript(range r: Range, granularity g: Granularity) -> OrderedCharts {
        get { elements.value(range: r, granularity: g) }
        set { elements["\(r.rawValue)\(g.rawValue)"] = newValue }
    }
        
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        if ts.dictionary == nil { ts.dictionary = [:] }
    }
}
