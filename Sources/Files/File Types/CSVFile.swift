//
//  CSVFile.swift
//  French-Rap-Lyrics-Corpus
//
//  Created by Lukas Danckwerth on 30.06.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

open class CSVFile: ContentFile<[[String]]> {
    
    open var seperator = ";"
    
    open var newLine = "\n"
    
    open var encoding: String.Encoding = .utf8
    
    open var containsTitleLine: Bool = true
    
    override public init(fileURL: URL, mustExist: Bool = false) {
        super.init(fileURL: fileURL, mustExist: mustExist)
    }
    
    open override func read() -> [[String]]? {
        guard let content = try? String(contentsOf: fileURL) else { return nil }
        let lines = content.components(separatedBy: self.newLine)
        let components: [[String]] = lines.compactMap({ $0.components(separatedBy: self.seperator) })
        return components
    }
    
    open override func snapshot() throws -> Data? {
        return value
            .compactMap({ $0.joined(separator: self.seperator) })
            .joined(separator: self.newLine)
            .data(using: encoding)
    }
}
