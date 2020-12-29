//
//  Codable + Read.swift
//  
//
//  Created by Lukas Danckwerth on 30.08.20.
//

import Foundation

public extension Encodable where Self: Decodable {
    
    init?(jsonURL: URL?) {
        guard let jsonURL = jsonURL else { return nil }
        do {
            self = try JSONDecoder().decode(Self.self, from: try Data(contentsOf: jsonURL))
        } catch {
            return nil
        }
    }
    
    init?(jsonString: String) {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        self.init(jsonData: jsonData)
    }
    
    init?(jsonData: Data) {
        do {
            self = try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            return nil
        }
    }
    
    /// Returns a copy of this `Codable`.  The copy is created by decoding and encoding this `Codable` to and from `Data`.
    var copy: Self? {
       do {
          return try JSONDecoder().decode(Self.self, from: JSONEncoder().encode(self))
       } catch let error {
          NSLog("Can't copy \(self).  \(error)")
       }
       return nil
    }
}
