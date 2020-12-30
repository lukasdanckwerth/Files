//
//  Location + Edit.swift
//  
//
//  Created by Lukas on 02.08.20.
//

import Foundation

public extension Location {
    
    /// Returns an `URL` by appending an underscore and a backup date (`"yyyy-MM-dd-HHmmssSSS"`)
    /// to the receivers url.
    ///
    var backupURL: URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HHmmss.SSS"
        let backupDateString = formatter.string(from: Date())
        return enclosingDirectoryURL!.appendingFileComponent(
            "\(nameExcludingExtension)_\(backupDateString)",
            withExtension: self.extension ?? ""
        )
    }
    
    /// Tries to backup the location.  Returns the `URL` of the backup file if successed,
    ///
    @discardableResult func backup() throws -> URL? {
        guard exists else { throw LocationError(location: self, reason: .notExisting) }
        return try copy(to: backupURL)
    }
    
    /// Tries to backup the location.  Returns the `URL` of the backup file if successed,
    ///
    @discardableResult func tryBackup() -> URL? {
        guard exists else { return nil }
        return try? copy(to: backupURL)
    }
}
