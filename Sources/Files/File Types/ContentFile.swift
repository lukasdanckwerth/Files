//
//  FileContent.swift
//  French-Rap-Lyrics-Corpus
//
//  Created by Lukas Danckwerth on 30.06.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

// ===-----------------------------------------------------------------------------------------------------------===
//
// MARK: - ContentFile
// ===-----------------------------------------------------------------------------------------------------------===

open class ContentFile<ContentType>: File {
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Properties
    // ===-----------------------------------------------------------------------------------------------------------===
    
    open var value: ContentType!
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Initialization
    // ===-----------------------------------------------------------------------------------------------------------===
    
    public init(fileURL: URL, mustExist: Bool = false) {
        super.init(at: fileURL)
        guard !mustExist || exists else {
            fatalError("file must exist: \(fileURL.path)\n")
        }
        self.value = read()
    }
    
    
    // ===-----------------------------------------------------------------------------------------------------------===
    //
    // MARK: - Functions
    // ===-----------------------------------------------------------------------------------------------------------===
    
    open func read() -> ContentType? {
        nil
    }
    
    open func snapshot() throws -> Data? {
        nil
    }
    
    open func store() throws {
        do {
            guard let data = try snapshot() else { return }
            try data.write(to: fileURL, options: .atomic)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @discardableResult
    open func storeUnsafe() -> Bool {
        do {
            try store()
            return true
        } catch {
            return false
        }
    }
}
