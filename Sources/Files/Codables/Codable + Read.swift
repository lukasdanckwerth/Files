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
        do {
            self = try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            return nil
        }
    }
    
    init?(jsonData: Data) {
        do {
            self = try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            return nil
        }
    }
}
