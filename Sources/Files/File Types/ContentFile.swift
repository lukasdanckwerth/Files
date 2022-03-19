//
//  FileContent.swift
//  Files
//
//  Created by Lukas Danckwerth on 30.06.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

open class ContentFile<ContentType>: File {

    open var value: ContentType!
    
    public init(fileURL: URL, mustExist: Bool = false) {
        super.init(at: fileURL)
        guard !mustExist || exists else {
            fatalError("file must exist: \(fileURL.path)\n")
        }
        self.value = read()
    }

    open func read() -> ContentType? {
        nil
    }
    
    open func snapshot() throws -> Data? {
        nil
    }
    
    open func store() throws {
        do {
            guard let data = try snapshot() else { return }
            try data.write(to: url, options: .atomic)
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
