//
//  Location + Edit.swift
//  
//
//  Created by Lukas on 02.08.20.
//

import Foundation

public extension Location {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Copy
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Copies the receiver to the location in the given `URL`.  Will return the destination `URL` if it was copied
    /// successfully or the file already exists.
    @discardableResult
    func copy(to destinationURL: URL) throws -> URL? {
        guard self.exists else { return nil }
        var destinationURL = destinationURL
        if destinationURL.isDirectory {
            destinationURL = destinationURL.appendingPathComponent(self.filename)
        }
        guard !destinationURL.exists else { return destinationURL }
        try fileManager.copyItem(at: self.fileURL, to: destinationURL)
        return destinationURL
    }
    
    @discardableResult
    func tryCopy(to destinationURL: URL) -> Bool {
        do {
            try _ = self.copy(to: destinationURL)
            return true
        } catch {
            NSLog(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult
    func copy(to targetDirectory: Directory) throws -> URL? {
        return try copy(to: targetDirectory.fileURL(filename: filename))
    }
    
    @discardableResult
    func tryCopy(to targetDirectory: Directory) -> Bool {
        do {
            try _ = self.copy(to: targetDirectory)
            return true
        } catch {
            NSLog(error.localizedDescription)
            return false
        }
    }
    
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Remove
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Removes the file specified by the receiver
    func remove() throws {
        try fileManager.removeItem(at: self.fileURL)
    }
    
    /// Removes the file at the given `URL`.  Returns `true` for success,  `false` if an error occured during removal.
    @discardableResult
    func tryRemove() -> Bool {
        do {
            try remove()
            return true
        } catch {
            NSLog(error.localizedDescription)
            return false
        }
    }
    
    /// Removes the file at the given `URL` only if it exists.  Returns `true` if given file does not exist or if it is
    /// removed.  Returns `false` if the file exists and can not be removed.
    @discardableResult
    func removeIfNeeded() -> Bool {
        guard self.exists else { return true }
        return tryRemove()
    }
}
