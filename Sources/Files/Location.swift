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
    var filename: String {
        return url.lastPathComponent
    }
    
    /// Returns WITHOUT extension the name of the file represented by this `URL`.
    ///
    var filenameWithoutExtension: String {
        return url.deletingPathExtension().lastPathComponent
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
    
    /// Returns a path of the receiver relative to the given URL.
    ///
    /// - parameter baseURL: The URL which is removed from path.
    /// - parameter replacement: The string used to replace the `baseURL`.
    func relativePath(_ baseURL: URL = .home, replacement: String = "{APPLICATION_HOME}") -> String {
        return url.relativePath.replacingOccurrences(of: baseURL.path, with: replacement)
    }
    
    func relativTo(_ baseURL: URL = .mainApplicationURL, replacement: String = "..") -> String {
        return url.relativePath.replacingOccurrences(of: baseURL.relativePath, with: replacement)
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
    
    
    @discardableResult func backup() -> Bool {
        guard exists else {
            return false
        }
        do {
            try fileManager.backup(fileAt: url)
            return true
        } catch {
            return false
        }
    }
    
    /// Returns an alternative `URL` for the receiver IF the receiver already exist;  returns the receiver else
    ///
    var toNonExistendFileURL: URL {
        let pureName = self.filenameWithoutExtension
        let theExtension = url.pathExtension
        var index = 1
        var candidate = url
        let directoryURL = candidate.deletingLastPathComponent()
        while candidate.exists {
            candidate = directoryURL
                .appendingPathComponent("\(pureName)_\(index)")
                .appendingPathExtension(theExtension)
            index += 1
        }
        return candidate
    }
}
