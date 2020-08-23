//
//  ExtensionURL.swift
//  WinValueUltraXpert
//
//  Created by Lukas Danckwerth on 14.08.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

public extension Location {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Filename
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Returns the name of the file represented by this `URL`.
    var filename: String {
        self.fileURL.lastPathComponent
    }
    
    /// Returns WITHOUT extension the name of the file represented by this `URL`.
    var filenameWithoutExtension: String {
        self.fileURL.deletingPathExtension().lastPathComponent
    }
    
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - File Manager Dependant
    // ===-----------------------------------------------------------------------------------------------------------===
    
    /// Returns the default `FileManager`.
    var fileManager: FileManager {
        return FileManager.default
    }
    
    /// Returns a Boolean value indicating whether the file exists.
    var exists: Bool {
        return fileManager.fileExists(atPath: self.fileURL.path)
    }
    
    /// Returns a boolean value indicating wheather the receiving `URL` is a directory.
    var isDirectory: Bool {
        var isDirectory: ObjCBool = false
        fileManager.fileExists(atPath: self.fileURL.path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
}
