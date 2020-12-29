//
//  URL + Defaults.swift
//  
//
//  Created by Lukas on 11.08.20.
//

import Foundation

extension URL {
    
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
}
