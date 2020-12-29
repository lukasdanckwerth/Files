//
//  Location.swift
//  Files
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

public protocol Location {
    var url: URL { get }
}

public extension Location {
    
    /// Returns the default `FileManager`.
    ///
    var fileManager: FileManager {
        return FileManager.default
    }
    
    /// Returns the name of the file represented by this `URL`.
    ///
    var name: String {
        return url.lastPathComponent
    }
    
    /// Returns WITHOUT extension the name of the file represented by this `URL`.
    ///
    var nameExcludingExtension: String {
        return url.deletingPathExtension().lastPathComponent
    }
    
    /// Returns the extension of the file.
    ///
    var `extension`: String? {
        let components = name.split(separator: ".")
        guard components.count > 1 else { return nil }
        return String(components.last!)
    }
    
    /// Returns a Boolean value indicating whether the file exists.
    ///
    var exists: Bool {
        return fileManager.fileExists(atPath: url.path)
    }
    
    /// Returns a boolean value indicating wheather the receiving `URL` is a directory.
    ///
    var isDirectory: Bool {
        var isDirectory: ObjCBool = false
        fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
    /// Returns the `URL` of the enclosing directory.
    ///
    var enclosingDirectoryURL: URL? {
        let directoryURL = url.deletingLastPathComponent()
        return directoryURL.isDirectory ? directoryURL : nil
    }
    
    /// Returns the enclosing directory.
    ///
    var enclosingDirectory: Directory? {
        guard let directoryURL = enclosingDirectoryURL else { return nil }
        return Directory(at: directoryURL)
    }
    
    /// Returns a path of the receiver relative to the given URL.
    ///
    /// - parameter baseURL: The URL which is removed from path.
    /// - parameter replacement: The string used to replace the `baseURL`.
    func relativeTo(_ baseURL: URL = .mainApplicationURL, replacement: String = "...") -> String {
        return url.relativePath.replacingOccurrences(of: baseURL.path, with: replacement)
    }
    
    /// Returns an alternative `URL` for the receiver IF the receiver already exist;  returns the receiver else
    ///
    var nonExistendURL: URL {
        let nameExcludingExtension = self.nameExcludingExtension
        let theExtension = self.extension ?? ""
        let directoryURL = url.deletingLastPathComponent()
        var index = 1
        var candidate = url
        
        while candidate.exists {
            candidate = directoryURL
                .appendingPathComponent("\(nameExcludingExtension)_\(index)")
                .appendingPathExtension(theExtension)
            index += 1
        }
        
        return candidate
    }
}
