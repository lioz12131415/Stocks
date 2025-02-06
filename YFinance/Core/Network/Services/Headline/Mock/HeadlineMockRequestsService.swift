//
//  HeadlineMockRequestsService.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Networking
import Foundation

public class HeadlineMockRequestsService: HeadlineRequestsService {
     
    public override func headlines(for symbol: String) async throws -> Headlines {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
    
    public override func response(for symbol: String) async throws -> Response<XML.Headlines> {
        throw HTTPError.invalid(.init(message: "TODO"))
    }
}
