//
//  Textfile.swift
//  frc-framework
//
//  Created by Lukas Danckwerth on 30.06.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - TextFile
// ===-----------------------------------------------------------------------------------------------------------===

open class TextFile: ContentFile<String> {
    
    public override func read() -> String? {
        return try? String(contentsOf: fileURL)
    }
    
    public override func snapshot() throws -> Data? {
        return value.data(using: .utf8)
    }
}
