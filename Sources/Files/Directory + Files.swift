//
//  Directory + Files.swift
//  Files
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension Directory {
    
    /// Returns a `URL` for a file in this directory with the given name and given extension.
    ///
    func fileURL(name: String, extension anExtension: String  = "") -> URL {
        return url.appendingPathComponent(name).appendingPathExtension(anExtension)
    }
    
    /// Returns a `File` in this directory with the given name.
    ///
    func file(name: String, extension anExtension: String  = "") -> File {
        return File(at: fileURL(name: name, extension: anExtension))
    }
    
    /// Returns a `URL` for a directory in this directory with the given name.
    ///
    func directoryURL(name: String, create: Bool = false) -> URL {
        return directory(name: name, create: create).url
    }
    
    /// Returns a `Directory` in this directory with the given name.
    ///
    func directory(name: String, create: Bool = false) -> Directory {
        let directory = Directory(at: url.appendingDirectoryComponent(name))
        if create { try? directory.create() }
        return directory
    }
    
    /// Returns `true` if a file with the given name exists in this directory.
    ///
    func containsFile(named name: String) -> Bool {
        return fileURL(name: name).exists
    }
}
