//
//  Codable + Files.swift
//  Files
//
//  Created by Lukas Danckwerth on 30.08.20.
//

import Foundation

public extension Encodable where Self: Decodable {
    
    /// Creates a new instance from the given `URL`.
    ///
    init?(jsonURL: URL?) {
        guard let jsonURL = jsonURL else { return nil }
        do {
            self = try JSONDecoder().decode(Self.self, from: try Data(contentsOf: jsonURL))
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    /// Creates a new instance from the given JSON string.
    ///
    init?(jsonString: String) {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        self.init(jsonData: jsonData)
    }
    
    /// Creates a new instance from the given JSON `Data`.
    ///
    init?(jsonData: Data) {
        do {
            self = try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    /// Returns a copy of this `Codable`.  The copy is created by decoding and encoding this `Codable` to and from `Data`.
    ///
    var copy: Self? {
        do {
            return try JSONDecoder().decode(Self.self, from: JSONEncoder().encode(self))
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
}
