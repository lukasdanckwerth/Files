//
//  Directory + Remove.swift
//  Files
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension Directory {
    
    /// Iterates the content array and calls the `remove()` message on each of the files.
    ///
    func removeContents() throws {
        try contents.forEach({ try $0.remove() })
    }
    
    /// Removes all files in the given directory ending with given extensions.
    ///
    func removeContents(withExtension anExtension: String) throws {
        try contents.filter({ $0.extension == anExtension }).forEach({ try $0.remove() })
    }
    
    /// Removes all files in the given directory ending with given extensions.
    ///
    func removeContents(withExtensions extensions: [String]) throws {
        try extensions.forEach({ try removeContents(withExtension: $0) })
    }
    
    /// Removes all files in the directory  (without throwing an error)
    ///
    @discardableResult func tryRemoveContents() -> Bool {
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
        return url.removeIfExists() && tryCreate()
    }
}
