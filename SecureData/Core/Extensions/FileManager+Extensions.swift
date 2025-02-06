//
//  FileManager+Extensions.swift
//  ¯\_(ツ)_/¯
//
//  Created by Lioz Balki on 01/01/1970.
//

import Foundation

extension FileManager {
    internal func read(from path: String) -> Data? {
        guard var url = urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        url = url.appendingPathComponent(path)
        
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }
}

extension FileManager {
    internal func write(_ data: Data?, to path: String) {
        guard let data = data,
              var url  = urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        url = url.appendingPathComponent(path)
        
        do {
            try data.write(to: url)
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
