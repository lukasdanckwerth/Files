//
//  URL + Appending Convenience.swift
//  
//
//  Created by Lukas on 11.08.20.
//

import Foundation

extension URL {
    
    /// Returns a URL constructed by appending the given path component and path extension to self.
    public func appendingFileComponent(_ fileComponent: String, withExtension anExtension: String) -> URL {
        self.appendingPathComponent(fileComponent).appendingPathExtension(anExtension)
    }
    
    /// Returns a URL constructed by appending the given path component to self with a trailing `"/"`.
    public func appendingDirectoryComponent(_ directoryComponent: String) -> URL {
        self.appendingPathComponent(directoryComponent, isDirectory: true)
    }
}
