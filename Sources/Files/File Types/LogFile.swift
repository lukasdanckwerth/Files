//
//  LogFile.swift
//  frc-framework
//
//  Created by Lukas Danckwerth on 30.06.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

open class LogFile: File {
    
    open func log(_ message: String, terminator: String = "\n") {
        
        let fullMessage = message + terminator
        
        guard let data = fullMessage.data(using: String.Encoding.utf8) else {
            return NSLog("Can't receive data by enconding utf8 from log message: %@", message)
        }
        
        if url.exists {
            do {
                let fileHandle = try FileHandle(forWritingTo: url)
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } catch {
                return NSLog("Can't create FileHandle for log file: %@", url.path)
            }
        }
        else {
            do {
                try data.write(to: url, options: .atomic)
            } catch {
                return NSLog("Can't write data to log file: %@", url.path)
            }
        }
    }
}
