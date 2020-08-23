//
//  File 2.swift
//  
//
//  Created by Lukas on 01.08.20.
//

import Foundation

// MARK: - File Manager Extension -

public extension FileManager {
    
    
    /// Removes the directory at the given `URL` if it exists; then creates it again.
    ///
    /// - parameter url: The `URL` of the directory to recreate.
    func recreateDirectory(_ url: URL) {
        if fileExists(atPath: url.path) {
            try? removeItem(at: url)
        }
        
        createDirectoryIfNotExists(url)
    }
    
    /// Creates the directory at the given `URL` if it doesn't exists.  Will do nothing if directory already exists.
    ///
    /// - parameter url: The `URL` of the directory to create.
    @discardableResult
    func createDirectoryIfNotExists(_ url: URL) -> URL {
        if !fileExists(atPath: url.path) {
            try? createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return url
    }
    
    /// Creates a backup of the file at the given `URL`.
    ///
    /// - parameter fileURL: The `URL` of the file to backup.
    func backup(fileAt fileURL: URL) throws {
        
        // guard file existence
        condition(self.fileExists(atPath: fileURL.path), "file must exist: \(fileURL.relativePath)")
        
        // receive formatted date string
        let formatedDate = DateFormatter.backupFilePrefix.string(from: Date())
        
        // receive file name
        let fileName = fileURL.deletingPathExtension().lastPathComponent
        
        // receive file extension
        let fileExtension = fileURL.pathExtension
        
        // receive target file URL
        let targetFileURL = fileURL
            .deletingLastPathComponent()
            .appendingPathComponent("\(fileName)-\(formatedDate)")
            .appendingPathExtension(fileExtension)
        
        // guard the target file not already exists
        condition(!FileManager.default.fileExists(atPath: targetFileURL.path), "file must not exist: \(targetFileURL.relativePath)")
        
        try copyItem(at: fileURL, to: targetFileURL)
    }
}



/// Checks a necessary condition for making forward progress.
///
/// - Parameters:
///   - condition:  The condition to test.
///   - message:    A string to print if `condition` is evaluated to `false`.
func condition(_ condition: Bool, _ message: String) {
    
    guard condition else {
        print("Error:", message, "\n")
        exit(0)
    }
}
