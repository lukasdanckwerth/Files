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
    func create(
        withIntermediateDirectories flag: Bool = true,
        attributes: [FileAttributeKey : Any]? = nil
    ) throws {
        try fileManager.createDirectory(
            at: url,
            withIntermediateDirectories: flag,
            attributes: attributes
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
    
    /// Creates the directory if it doesn't exist.
    ///
    func createIfNotExists() {
        if !exists { try? create() }
    }
}
