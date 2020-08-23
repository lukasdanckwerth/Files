//
//  File.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `File`
// ===-----------------------------------------------------------------------------------------------------------===

open class File: Location {
    
    open var fileURL: URL
    
    public init(at path: String) {
        self.fileURL = URL(fileURLWithPath: path)
    }
    
    public init(at url: URL) {
        self.fileURL = url
    }
}
