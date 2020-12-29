//
//  Location + Edit.swift
//  
//
//  Created by Lukas on 02.08.20.
//

import Foundation

public extension Location {
    
    /// Removes the file specified by the receiver.
    ///
    func remove() throws {
        try fileManager.removeItem(at: url)
    }
    
    /// Removes the file at the given `URL`.  Returns `true` for success,  `false` if an error occured during removal.
    ///
    @discardableResult func tryRemove() -> Bool {
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
    ///
    @discardableResult func removeIfExists() -> Bool {
        guard self.exists else { return true }
        return tryRemove()
    }
}
