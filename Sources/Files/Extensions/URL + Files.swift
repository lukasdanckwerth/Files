//
//  ExtensionURL.swift
//  Files
//
//  Created by Lukas Danckwerth on 14.08.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

extension URL: Location {
    
    // MARK: - Location conformance
    
    public var url: URL { return self }
    
    // MARK: - Defaults
    
    /// Reference to the app's main directory (`"../"`)
    ///
    public static var mainApplicationURL: URL {
        return URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true)
    }
    
    /// Reference to the users home directory (`"~"`)
    ///
    public static var home: URL {
        return URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true)
    }
    
    /// Reference to the app's tmp directory (`"../tmp"`)
    ///
    public static var temporary: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    /// Reference to the app's library directory (`"../Library"`)
    ///
    public static var library: URL {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
    }
    
    /// Reference to the app's library support directory (`"../Library/Application Support"`)
    ///
    public static var librarySupport: URL {
        return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }
    
    /// Reference to the app's document directory (`"../Documents"`)
    ///
    public static var documentsDirectoryURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    /// Reference to the app's preferences directory (`"../Library/Preferences"`)
    ///
    public static var preferences: URL {
        library.appendingDirectoryComponent("Preferences")
    }
    
    // MARK: - Temporary
    
    /// Creates and returns a temporary file `URL` in the app's temporary directory based on `"UUID"`.
    ///
    init(temporaryFileWithExtension anExtension: String) {
        let tempFileURL = URL.temporary.appendingFileComponent(NSUUID().uuidString, withExtension: anExtension)
        self = tempFileURL.exists ? URL(temporaryFileWithExtension: anExtension) : tempFileURL
    }
    
    /// Creates and returns a temporary file `URL` in the app's temporary directory based on `"UUID"`.
    ///
    static func temporaryFileURL(withExtension aExtension: String? = nil) -> URL {
        let directory = URL.temporary
        var url = directory.appendingPathComponent(NSUUID().uuidString)
        if let aExtension = aExtension { url.appendPathExtension(aExtension) }
        return url.exists ? temporaryFileURL(withExtension: aExtension) : url
    }
    
    /// Creates and returns a temporary directory `URL` in the app's temporary directory based on `"UUID"`.  The directory will be created.
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
    
    // MARK: - Appending Convenience
    
    /// Returns a URL constructed by appending the given path component and path extension to self.
    ///
    public func appendingFileComponent(_ fileComponent: String, withExtension anExtension: String) -> URL {
        self.appendingPathComponent(fileComponent).appendingPathExtension(anExtension)
    }
    
    /// Returns a URL constructed by appending the given path component to self with a trailing `"/"`.
    ///
    public func appendingDirectoryComponent(_ directoryComponent: String) -> URL {
        self.appendingPathComponent(directoryComponent, isDirectory: true)
    }
}
