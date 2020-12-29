//
//  Directory + Print Contents.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

extension Directory {
    
    /// Date formatter used for formatting creation date of files when printing contents.
    ///
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd.MM HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    /// Returns a string containing the file tree of the directory.
    ///
    @available(OSX 10.11, *)
    public func formatContents(recursive: Bool = true) -> String {
        return formatContents(directory: self, recursive: recursive)
    }
    
    ///
    ///
    @available(OSX 10.11, *)
    private func formatContents(directory: Directory, recursive: Bool = true, intend: Int = 0) -> String {
        
        // receive date formatter
        let dateFormatter = Self.dateFormatter
        
        // receive and sort content URLs
        let contents = directory.contents.sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
        
        // iterate files and build content tree
        return contents.reduce("", { text, fileURL in
            
            var text = text
            text += String(repeating: "|  ", count: intend) + "├─ "
            
            let modificationDate = fileURL.modificationDate ?? Date.distantPast
            let formattedDate = dateFormatter.string(from: modificationDate)
            
            if recursive, fileURL.hasDirectoryPath {
                let directory = Directory(at: fileURL)
                text += fileURL.filename + " (\(formattedDate))\n"
                text += formatContents(directory: directory, intend: intend + 1)
            } else {
                text += fileURL.filename + " (\(formattedDate), \(fileURL.formattedSize))\n"
            }
            
            return text
        })
    }
    
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Print Contents
    // ===-----------------------------------------------------------------------------------------------------------===
    
    @available(OSX 10.11, *)
    public func printContents(recursive: Bool = true) {
        print("""
            Contents of "\(url.relativePath())"
            
            \(formatContents(recursive: recursive))
            """)
    }
}
