//
//  Location + Convenience.swift
//  
//
//  Created by Lukas on 02.08.20.
//

import Foundation

public extension Location {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Relative Path
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Returns a path of the receiver relative to the given URL.
    ///
    /// - parameter baseURL: The URL which is removed from path.
    /// - parameter replacement: The string used to replace the `baseURL`.
    func relativePath(_ baseURL: URL = .home, replacement: String = "{APPLICATION_HOME}") -> String {
        self.fileURL.relativePath.replacingOccurrences(of: baseURL.path, with: replacement)
    }
    
    func relativTo(_ baseURL: URL = .mainApplicationURL, replacement: String = "..") -> String {
        self.fileURL.relativePath.replacingOccurrences(of: baseURL.relativePath, with: replacement)
    }
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Convenience
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Returns the `URL` of the enclosing directory.
    var enclosingDirectoryURL: URL? {
        let directoryURL = fileURL.deletingLastPathComponent()
        return directoryURL.isDirectory ? directoryURL : nil
    }
    
    /// Returns the enclosing directory.
    var enclosingDirectory: Directory? {
        guard let directoryURL = enclosingDirectoryURL else { return nil }
        return Directory(at: directoryURL)
    }
    
    @discardableResult
    func backup() -> Bool {
        guard self.exists else { return false }
        do {
            try fileManager.backup(fileAt: fileURL)
            return true
        } catch {
            return false
        }
    }
    
    /// Returns an alternative `URL` for the receiver IF the receiver already exist;  returns the receiver else
    var toNonExistendFileURL: URL {
        let pureName = self.filenameWithoutExtension
        let theExtension = self.fileURL.pathExtension
        var index = 1
        var candidate = self.fileURL
        let directoryURL = candidate.deletingLastPathComponent()
        while candidate.exists {
            candidate = directoryURL
                .appendingPathComponent("\(pureName)_\(index)")
                .appendingPathExtension(theExtension)
            index += 1
        }
        return candidate
    }
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Statics
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Removes all files in the given collection of URLs.
    static func removeItems(_ urls: [URL]) {
        urls.forEach({ try? $0.remove() })
    }
    
    /// Returns a formatted string of the given size.
    static func covertToFileString(with size: UInt64) -> String {
        var convertedValue: Double = Double(size)
        var multiplyFactor = 0
        let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        while convertedValue > 1024 {
            convertedValue /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
    }
}
