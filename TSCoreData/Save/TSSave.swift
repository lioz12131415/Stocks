//
//  TSSave.swift
//  TSCoreData
//
//  Created by Lioz Balki on 1/01/1970.
//

import CoreData
import Foundation

public enum TSSave<P: TSPerform> {
    case sync
    case async
    
    internal func execute() {
        switch self {
            case .sync:  P.sync  { save() }
            case .async: P.async { save() }
        }
    }
}

extension TSSave {
    fileprivate func save() {
        P.context.registeredObjects.forEach {
            $0.cow()
        }
        do {
            try P.context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
