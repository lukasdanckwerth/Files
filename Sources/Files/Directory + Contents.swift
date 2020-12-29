//
//  Directory + Contents.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

extension Directory {
    
    /// Returns an array of `URL`s in the given directory.
    ///
    public var contents: [URL] {
        return (try? fileManager.contentsOfDirectory(
            at: url,
            includingPropertiesForKeys: nil,
            options: .skipsHiddenFiles
        )) ?? []
    }
    
    /// Returns a Boolean value indicating whether the directory is empty
    ///
    public var isEmpty: Bool {
        return contents.isEmpty
    }
    
    /// Returns the size of the folder at the given `URL` in bytes.  Size is calculated recursivly.
    ///
    var recursiveSize: Int64 {
        return contents.reduce(Int64(0), {
            if $1.isDirectory {
                return $0 + Directory(at: $1).recursiveSize
            } else {
                return $0 + Int64($1.size)
            }
        })
    }
    
    /// Returns a formatted string representing the size of the folder at the given `URL`.
    ///
    var formattedRecursiveSize: String {
        return ByteCountFormatter().string(fromByteCount: self.recursiveSize)
    }
}
