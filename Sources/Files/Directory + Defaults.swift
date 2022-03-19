//
//  Directory.swift
//  Files
//
//  Created by Lukas Danckwerth on 09.10.19.
//  Copyright © 2019 Lukas Danckwerth. All rights reserved.
//

import Foundation

extension Directory {
    
    /// Reference to the app's document directory (`"~"`)
    ///
    public static var home: Directory {
        return Directory(at: .home)
    }
    
    /// Reference to the app's tmp directory (`"../tmp"`)
    ///
    public static var temporary: Directory {
        return Directory(at: .temporary)
    }
    
    /// Reference to the app's library directory (`"../Library"`)
    ///
    public static var library: Directory {
        return Directory(at: .library)
    }
    
    /// Reference to the app's preferences directory (`"../Library/Preferences"`)
    ///
    public static var preferences: Directory {
        return Directory(at: .preferences)
    }
    
    /// Reference to the app's library support directory (`"../Library/Application Support"`)
    ///
    public static var librarySupport: Directory {
        return Directory(at: .librarySupport)
    }
    
    /// Reference to the app's document directory (`"../Documents"`)
    ///
    public static var documents: Directory {
        return Directory(at: .documentsDirectoryURL)
    }
}
