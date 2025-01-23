//
//  Crumb+CoreDataClass.swift
//  YFinance
//
//  Created by Lioz Balki on 1/01/1970.
//
//

import CoreData
import TSCoreData
import Networking

@objc(Crumb)
public class Crumb: NSManagedObject, TSManagedObject {
    
    fileprivate static var cookies:        HTTPCookies            = HTTPCookies.shared
    fileprivate static var crumbService:   CrumbRequestsService   = CrumbRequestsService()
    fileprivate static var cookiesService: CookiesRequestsService = CookiesRequestsService()
    
    public static var context: NSManagedObjectContext {
        return CoreDataManeger.crumbContext
    }
    
    public static func get() async throws -> Crumb {
        guard let crumb = first else {
            return try await request()
        }
        guard let date = crumb.ts.expiresDate, !date.isExpired else {
            return try await request(crumb)
        }
        return crumb
    }
}

extension Crumb {
    fileprivate static func request(_ crumb: Crumb = .new) async throws -> Crumb {
        cookies.remove {
            $0.domain == ".yahoo.com"
        }
        
        let cookie = try await cookiesService.get()
        let string = try await crumbService.get(cookie: cookie)
        
        crumb.ts
            .set(string,             for: \.key)
            .set(cookie.name,        for: \.name)
            .set(cookie.domain,      for: \.domain)
            .set(cookie.expiresDate, for: \.expiresDate)
        
        Crumb.save(.sync)
        return crumb
    }
}
