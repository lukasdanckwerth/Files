//
//  LogFile.swift
//  frc-framework
//
//  Created by Lukas Danckwerth on 30.06.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

class LogFile: File {
    
    func log(_ message: String, terminator: String = "\n") {
        
        let fullMessage = message + terminator
        
        guard let data = fullMessage.data(using: String.Encoding.utf8) else {
            return NSLog("Can't receive data by enconding utf8 from log message: %@", message)
        }
        
        if fileURL.exists {
            do {
                let fileHandle = try FileHandle(forWritingTo: fileURL)
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } catch {
                return NSLog("Can't create FileHandle for log file: %@", fileURL.path)
            }
        }
        else {
            do {
                try data.write(to: fileURL, options: .atomic)
            } catch {
                return NSLog("Can't write data to log file: %@", fileURL.path)
            }
        }
    }
}
