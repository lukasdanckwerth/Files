//
//  Directory + Create.swift
//  Files
//
//  Created by Lukas on 29.12.20.
//

import Foundation

public extension Directory {
    
    /// Tries to create the directory.
    ///
    func create(withIntermediateDirectories flag: Bool = true) throws {
        try fileManager.createDirectory(
            at: url,
            withIntermediateDirectories: flag,
            attributes: [:]
        )
    }
    
    /// Tries to create the directory.
    ///
    @discardableResult func tryCreate() -> Bool {
        do {
            try create()
            return true
        } catch {
            NSLog(error.localizedDescription)
            return false
        }
    }
    
//    /// Creates the directory if it doesn't exist.
//    ///
//    @discardableResult func createIfNeeded() -> URL? {
//        return fileManager.createDirectoryIfNotExists(url)
//    }
}
