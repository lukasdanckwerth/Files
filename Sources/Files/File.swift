//
//  File.swift
//  Files
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

open class File: Location {
    
    public var url: URL
    
    public init(at path: String) {
        self.url = URL(fileURLWithPath: path)
    }
    
    public init(at url: URL) {
        self.url = url
    }
}
