//
//  Location.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - `URL` + `Location`
// ===-----------------------------------------------------------------------------------------------------------===

public protocol Location {
   var fileURL: URL { get }
   var size: Int64 { get }
}
