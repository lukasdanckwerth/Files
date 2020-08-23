//
//  ExtensionURL.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 14.08.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `URL` + `Location`
// ===-----------------------------------------------------------------------------------------------------------===

extension URL: Location {
    public var fileURL: URL { return self }
}
