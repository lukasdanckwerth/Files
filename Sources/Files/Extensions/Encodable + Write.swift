//
//  Encodable + Convenience.swift
//  Files
//
//  Created by Lukas Danckwerth on 11.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation

public extension Encodable {
    
    func write(to url: URL) throws {
        try self.jsonData?.write(to: url, options: .atomic)
    }
    
    @discardableResult func tryWrite(to url: URL) -> Bool {
        do {
            try write(to: url)
            return true
        } catch {
            return false
        }
    }
}
