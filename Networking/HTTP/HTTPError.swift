//
//  HTTPError.swift
//  Networking
//
//  Created by ליעוז בלקי on 17/12/2024.
//

import Foundation

public enum HTTPError: Error {
    case cancelled
    case invalid(Context)
}

extension HTTPError {
    public struct Context {
        
        var status:  Int = -999
        var message: String
        
        public init(error: Error) {
            self.message = error.localizedDescription
        }
        
        public init(message: String) {
            self.message = message
        }
        
        public init(status: Int, message: String) {
            self.status  = status
            self.message = message
        }
    }
}

