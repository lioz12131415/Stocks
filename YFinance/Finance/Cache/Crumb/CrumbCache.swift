//
//  CrumbCache.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import SecureData
import Networking
import Foundation

final
public class CrumbCache: NSObject {
    
    typealias Secure = SecureObject<Crumb>
    
    fileprivate lazy var secure:         Secure                 = Secure(key)
    fileprivate lazy var cookies:        HTTPCookies            = HTTPCookies.shared
    fileprivate lazy var crumbService:   CrumbRequestsService   = CrumbRequestsService()
    fileprivate lazy var cookiesService: CookiesRequestsService = CookiesRequestsService()
    
    fileprivate var key: String {
        return "cache.secure.crumb"
    }
    
    private(set) public static var get: CrumbCache = {
        return CrumbCache()
    }()
        
    fileprivate override init() {
        super.init()
    }
    
    public func fetch() async throws -> Crumb {
        guard let date = secure.expiresDate, !date.isExpired else {
            return try await request()
        }
        return secure.element
    }
}

extension CrumbCache {
    fileprivate func request() async throws -> Crumb {
        cookies.remove {
            $0.domain == ".yahoo.com"
        }
        
        let cookie = try await cookiesService.get()
        let string = try await crumbService.get(cookie: cookie)
        
        secure
            .set(string,             for: \.key)
            .set(cookie.name,        for: \.name)
            .set(cookie.domain,      for: \.domain)
            .set(cookie.expiresDate, for: \.expiresDate)

        secure.save()
        return secure.element
    }
}
