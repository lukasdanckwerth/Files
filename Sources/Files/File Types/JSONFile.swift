//
//  JSONFile.swift
//  Files
//
//  Created by Lukas Danckwerth on 30.06.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - JSONFile
// ===-----------------------------------------------------------------------------------------------------------===

open class JSONFile<JSONType: Codable>: ContentFile<JSONType> {
    
    open override func read() -> JSONType? {
        guard fileManager.fileExists(atPath: url.path) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("can't read data: \(url.path)")
        }
        
        do {
            return try JSONDecoder().decode(JSONType.self, from: data)
        } catch {
            return nil
        }
    }
    
    open override func snapshot() -> Data? {
        // backup()
        let encoder = JSONEncoder()
        
        #if canImport(UIKit)
        if #available(iOS 11.0, *) {
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        } else {
            encoder.outputFormatting = [.prettyPrinted]
        }
        #elseif canImport(AppKit)
        if #available(OSX 10.13, *) {
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        } else {
            encoder.outputFormatting = [.prettyPrinted]
        }
        #endif
        
        return try? encoder.encode(value)
    }
}
