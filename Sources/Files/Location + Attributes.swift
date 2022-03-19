//
//  URL + Attributes.swift
//  Files
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension Location {
    
    /// Returns the attributes as received by the file manager.
    ///
    private var attributes: [FileAttributeKey : Any]? {
        return try? fileManager.attributesOfItem(atPath: self.url.path)
    }
    
    /// Returns the modification date ofo the file.
    ///
    var modificationDate: Date? {
        return attributes?[.modificationDate] as? Date
    }
    
    /// Returns the creation date of the file.
    ///
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
    
    /// Returns the type of the file.
    ///
    var type: String? {
        return attributes?[.type] as? String
    }
    
    /// Returns the size of the file in bytes.
    ///
    var size: Int64 {
        return attributes?[FileAttributeKey.size] as? Int64 ?? 0
    }
    
    // MARK: - Convenience
    
    /// Returns a formatted string representing the size of the item at the given `URL`.
    ///
    var formattedSize: String {
        return ByteCountFormatter().string(fromByteCount: self.size)
    }
}
