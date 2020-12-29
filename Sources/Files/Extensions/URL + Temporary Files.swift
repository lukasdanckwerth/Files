//
//  URL + Temporary Files.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

extension URL {
    
    /// Creates and returns a temporary file `URL` in the app's temporary directory
    /// based on `"UUID"`.
    ///
    init(temporaryFileWithExtension anExtension: String) {
        let tempFileURL = URL.temporary.appendingFileComponent(NSUUID().uuidString, withExtension: anExtension)
        self = tempFileURL.exists ? URL(temporaryFileWithExtension: anExtension) : tempFileURL
    }
    
    /// Creates and returns a temporary file `URL` in the app's temporary directory
    /// based on `"UUID"`.
    ///
    static func temporaryFileURL(withExtension aExtension: String? = nil) -> URL {
        let directory = URL.temporary
        var url = directory.appendingPathComponent(NSUUID().uuidString)
        if let aExtension = aExtension { url.appendPathExtension(aExtension) }
        return url.exists ? temporaryFileURL(withExtension: aExtension) : url
    }
    
    /// Creates and returns a temporary directory `URL` in the app's temporary directory
    /// based on `"UUID"`.  The directory will be created.
    ///
    ///
    static func temporaryDirectoryURL() throws -> URL {
        let url = URL.temporary.appendingPathComponent(NSUUID().uuidString)
        guard !url.exists else { return try temporaryDirectoryURL() }
        try FileManager.default.createDirectory(
            at: url,
            withIntermediateDirectories: false,
            attributes: nil
        )
        return url
    }
}
