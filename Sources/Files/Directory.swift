//
//  Directory.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 09.10.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

open class Directory: Location {
    
    public var url: URL
    
    required public init(at path: String) {
        self.url = URL(fileURLWithPath: path)
    }
    
    required public init(at url: URL) {
        self.url = url
    }
    
    required public init?(at directoryURL: URL, create: Bool) {
        self.url = directoryURL
        guard create else { return }
        do {
            try self.create()
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
}
