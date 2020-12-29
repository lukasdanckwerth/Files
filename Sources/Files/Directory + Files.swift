//
//  Directory + Files.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

public extension Directory {
    
    /// Returns a `URL` for a file in this directory with the given name.
    ///
    func fileURL(filename: String) -> URL {
        url.appendingPathComponent(filename)
    }
    
    /// Returns a `URL` for a file in this directory with the given name and given extension.
    ///
    func fileURL(fileName: String, extension anExtension: String) -> URL {
        url.appendingPathComponent(fileName).appendingPathExtension(anExtension)
    }
    
    /// Returns a `File` in this directory with the given name.
    ///
    func file(named name: String) -> File {
        File(at: self.fileURL(filename: name))
    }
    
    /// Returns a `URL` for a directory in this directory with the given name.
    ///
    func directoryURL(named name: String, create: Bool = false) -> URL {
        let directoryURL = self.url.appendingDirectoryComponent(name)
        if create { try? Directory(at: directoryURL).create() }
        return directoryURL
    }
    
    /// Returns a `Directory` in this directory with the given name.
    ///
    func directory(named name: String, create: Bool = false) -> Directory {
        let directory = Directory(at: self.url.appendingDirectoryComponent(name))
        if create { try? directory.create() }
        return directory
    }
    
    /// Returns a `Directory` in this directory with the given name.
    ///
    func directory(named name: String) -> Directory {
        return Directory(at: directoryURL(named: name))
    }
    
    /// Returns `true` if a file with the given name exists in this directory.
    ///
    func containsFile(named filename: String) -> Bool {
        return url.appendingPathComponent(filename).exists
    }
    
    
    func toNonExistendFilename(_ filename: String) -> String {
        guard !containsFile(named: filename) else { return filename }
        
        var index = 0
        var candidate = filename
        
        let components = filename.components(separatedBy: ".")
        
        if components.count > 1 {
            let pureFilename = filename.components(separatedBy: ".").first!
            let fileExtension = filename.components(separatedBy: ".").last!
            
            while containsFile(named: candidate) {
                index += 1
                candidate = "\(pureFilename)_\(index).\(fileExtension)"
            }
        } else {
            while containsFile(named: candidate) {
                index += 1
                candidate = "\(filename)_\(index)"
            }
        }
        
        return candidate
    }
}
