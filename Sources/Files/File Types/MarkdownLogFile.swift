//
//  MarkdownLogFile.swift
//  
//
//  Created by Lukas on 28.12.20.
//

import Foundation

class MarkdownLogFile: LogFile {
    
    func h1(_ headline: String) {
        log("# \(headline)")
    }
    
    func h2(_ headline: String) {
        log("## \(headline)")
    }
    
    func h3(_ headline: String) {
        log("### \(headline)")
    }
    
    func h4(_ headline: String) {
        log("#### \(headline)")
    }
    
    func h5(_ headline: String) {
        log("##### \(headline)")
    }
    
    func tableHeadline(_ line: String...) {
        let firstLine = "| \(line.joined(separator: " | ")) |"
        let secondLine = "| \(line.compactMap({ String(repeating: "-", count: $0.count) }).joined(separator: " | ")) |"
        log("\(firstLine)\n")
        log("\(secondLine)\n")
    }
    
    func table(_ line: String...) {
        log("| \(line.joined(separator: " | ")) |\n")
    }
}
