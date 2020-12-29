//
//  Directory + Edit.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
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
    @discardableResult func createIfNeeded() -> URL? {
        return fileManager.createDirectoryIfNotExists(url)
    }
    
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
    
    /// Removes and creates this `Directory`.
    ///
    @discardableResult func removeAndCreate() -> Bool {
        return url.removeIfExists() && self.tryCreate()
    }
    
    /// Iterates the content array and calls the `remove()` message on each of the files.
    ///
    func removeContents() throws {
        try self.contents.forEach({ try $0.remove() })
    }
    
    /// Removes all files in the given directory ending with given extensions.
    ///
    func removeContents(withExtensions extensions: [String]) throws {
        try self.contents.filter({ extensions.contains($0.pathExtension) }).forEach({ try $0.remove() })
    }
}
