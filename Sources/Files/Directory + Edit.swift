//
//  Directory + Edit.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension Directory {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Creation
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Tries to create the directory.
    func create(withIntermediateDirectories flag: Bool = true) throws {
        try fileManager.createDirectory(
            at: fileURL,
            withIntermediateDirectories: flag,
            attributes: [:]
        )
    }
    
    @discardableResult
    func tryCreate() -> Bool {
        do {
            try create()
            return true
        } catch {
            NSLog(error.localizedDescription)
            return false
        }
    }
    
    /// Creates the directory if it doesn't exist.
    @discardableResult
    func createIfNeeded() -> URL? {
        return fileManager.createDirectoryIfNotExists(fileURL)
    }
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Remove
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Removes all files in the directory  (without throwing an error)
    @discardableResult
    func removeReturningSuccess() -> Bool {
        do {
            try removeContents()
            return true
        } catch {
            NSLog(error.localizedDescription)
            return false
        }
    }
    
    /// Removes and creates the dossier directory.
    @discardableResult
    func removeAndCreateDirectory() -> Bool {
        if #available(OSX 10.11, *) {
            return fileURL.hasDirectoryPath && fileURL.removeIfNeeded() && self.tryCreate()
        } else {
            return fileURL.removeIfNeeded() && self.tryCreate()
        }
    }
    
    /// Iterates the content array and calls the `remove()` message on each of the files.
    func removeContents() throws {
        try self.contents.forEach({ try $0.remove() })
    }
    
    /// Removes all files in the given directory ending with given extensions.
    func removeContents(withExtensions extensions: [String]) throws {
        try self.contents.filter({ extensions.contains($0.pathExtension) }).forEach({ try $0.remove() })
    }
    
    func file(named name: String) -> File {
        return File(at: fileURL.appendingPathComponent(name))
    }
    
    func directory(named name: String) -> Directory {
        return Directory(at: fileURL.appendingDirectoryComponent(name))
    }
}
