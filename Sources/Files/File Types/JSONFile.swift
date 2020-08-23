//
//  JSONFile.swift
//  French-Rap-Lyrics-Corpus
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
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("can't read data: \(fileURL.path)")
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
        if #available(OSX 10.13, *) {
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        } else {
            encoder.outputFormatting = [.prettyPrinted]
        }
        return try? encoder.encode(value)
    }
}
