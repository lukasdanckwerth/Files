//
//  Directory + Print Contents.swift
//  Files
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

extension Directory {
    
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM HH:mm:ss"
        return formatter
    }
    
    /// Prints the contents of this directory to the standart out.
    ///
    public func printContents(recursive: Bool = true) {
        print("""
            Contents of "\(url.relativeTo())"
            
            \(formatContents(recursive: recursive))
            """)
    }
    
    /// Returns a string containing the file tree of the directory.
    ///
    public func formatContents(recursive: Bool = true) -> String {
        return formatContents(directory: self, recursive: recursive)
    }
    
    /// Returns a string containing the file tree of the directory.
    ///
    private func formatContents(directory: Directory, recursive: Bool = true, intend: Int = 0) -> String {
        
        let contents = directory.contents.sorted(by: { $0.name < $1.name })
        
        // iterate files and build content tree
        return contents.reduce("", { text, fileURL in
            
            var text = text
            text += String(repeating: "|  ", count: intend) + "├─ "
            
            let modificationDate = fileURL.modificationDate ?? Date.distantPast
            let formattedDate = Directory.dateFormatter.string(from: modificationDate)
            
            if recursive, fileURL.isDirectory {
                let directory = Directory(at: fileURL)
                text += fileURL.name + " (\(formattedDate))\n"
                text += formatContents(directory: directory, intend: intend + 1)
            } else {
                text += fileURL.name + " (\(formattedDate), \(fileURL.formattedSize))\n"
            }
            
            return text
        })
    }
}
