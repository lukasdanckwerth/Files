//
//  URL + Temporary Files.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

// ===--------------------------------------------------------------------------------------------------------------===
//
// MARK: - Temporary Files
// ===--------------------------------------------------------------------------------------------------------------===

extension URL {
    
    /// Creates and returns a temporary file `URL` in the app's temporary directory based on `"UUID"`.
    init(temporaryFileWithExtension anExtension: String) {
        let tempFileURL = URL.temporary.appendingFileComponent(NSUUID().uuidString, withExtension: anExtension)
        self = tempFileURL.exists ? URL(temporaryFileWithExtension: anExtension) : tempFileURL
    }
    
    /// Creates and returns a temporary file `URL` in the app's temporary directory based on `"UUID"`.
    static func createTemporaryFileURL(withExtension aExtension: String? = nil) -> URL {
        let directory = URL.temporary
        var url = directory.appendingPathComponent(NSUUID().uuidString)
        if let aExtension = aExtension { url.appendPathExtension(aExtension) }
        return url.exists ? createTemporaryFileURL(withExtension: aExtension) : url
    }
    
    //   /// Runs in background.  The `completion` block is called from main thread
    //   static func clearTemoraryDirectory(completion: (() -> ())? = nil) {
    //      DispatchQueue.global(qos: .background).async {
    //         let temporaryDirectory = Directory(at: URL.temporary)
    //         try? temporaryDirectory.removeContents()
    //         guard let completion = completion else { return }
    //         DispatchQueue.main.async { completion() }
    //      }
    //   }
}
