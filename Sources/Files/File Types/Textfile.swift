//
//  Textfile.swift
//  Files
//
//  Created by Lukas Danckwerth on 30.06.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

open class TextFile: ContentFile<String> {
    
    public override func read() -> String? {
        return try? String(contentsOf: url)
    }
    
    public override func snapshot() throws -> Data? {
        return value.data(using: .utf8)
    }
}
