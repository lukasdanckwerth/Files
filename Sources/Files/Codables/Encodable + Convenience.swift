//
//  Encodable + Convenience.swift
//  Files
//
//  Created by Lukas Danckwerth on 11.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation

public extension Encodable {
    
    var dictionary: [String: Any]! {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    var jsonData: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    var prettyJSONData: Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(self)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    var jsonString: String? {
        if let jsonData = self.jsonData {
            return String(data: jsonData, encoding: .utf8)
        }
        return nil
    }
    
    var prettyJSONString: String? {
        if let prettyJSONData = self.prettyJSONData {
            return String(data: prettyJSONData, encoding: .utf8)
        }
        return nil
    }
    
    func write(to destinationURL: URL) throws {
        try self.jsonData?.write(to: destinationURL, options: .atomic)
    }
    
    @discardableResult
    func writeSimple(to destinationURL: URL) -> Bool {
        do {
            try write(to: destinationURL)
            return true
        } catch {
            return false
        }
    }
}
