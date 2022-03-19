//
//  Encodable + Convenience.swift
//  Files
//
//  Created by Lukas Danckwerth on 11.01.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension Encodable {
    
    /// Tries to write the `Encodable` to the specified `URL`.
    ///
    /// - parameter url: The `URL` to write the `Encodable` to as JSON
    func write(to url: URL) throws {
        try self.jsonData?.write(to: url, options: .atomic)
    }
    
    /// Wrapps the `write(URL)` function in a do-try-catch block.
    ///
    /// - parameter url: The `URL` to write the `Encodable` to as JSON
    ///
    /// - returns: Success of writing the file
    @discardableResult func tryWrite(to url: URL) -> Bool {
        do {
            try write(to: url)
            return true
        } catch {
            return false
        }
    }
    
    /// Returns a dictionary representation of the receiver.
    ///
    var dictionary: [String: Any]! {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(
            with: data, options: .allowFragments)
        ).flatMap { $0 as? [String: Any] }
    }
    
    /// Returns the JSON data of the receiver.
    ///
    var jsonData: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    /// Returns the JSON data of the receiver.  The JSON is formatted with
    /// pretty printed.
    ///
    var prettyJSONData: Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(self)
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    /// Returns the JSON string of the receiver.
    ///
    var jsonString: String? {
        guard let jsonData = self.jsonData else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// Returns the JSON string of the receiver.  The JSON is formatted with
    /// pretty printed.
    ///
    var prettyJSONString: String? {
        guard let prettyJSONData = self.prettyJSONData else { return nil }
        return String(data: prettyJSONData, encoding: .utf8)
    }
}
