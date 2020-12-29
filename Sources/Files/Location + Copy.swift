//
//  Location + Edit.swift
//  
//
//  Created by Lukas on 02.08.20.
//

import Foundation

public extension Location {
    
    /// Copies the receiver to the location in the given `URL`.  Will return the destination `URL` if it was copied
    /// successfully or the file already exists.
    ///
    @discardableResult func copy(to destinationURL: URL) throws -> URL? {
        guard self.exists else { return nil }
        var destinationURL = destinationURL
        if destinationURL.isDirectory {
            destinationURL = destinationURL.appendingPathComponent(self.name)
        }
        guard !destinationURL.exists else { return destinationURL }
        try fileManager.copyItem(at: self.url, to: destinationURL)
        return destinationURL
    }
    
    @discardableResult func tryCopy(to destinationURL: URL) -> Bool {
        do {
            try _ = self.copy(to: destinationURL)
            return true
        } catch {
            NSLog(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult func copy(to directory: Directory) throws -> URL? {
        return try copy(to: directory.fileURL(name: name))
    }
    
    @discardableResult func tryCopy(to directory: Directory) -> Bool {
        return tryCopy(to: directory.fileURL(name: name))
    }
}
