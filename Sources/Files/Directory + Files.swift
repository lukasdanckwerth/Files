//
//  Directory + Files.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

import Foundation

extension Directory {
   
   public func fileURL(filename: String) -> URL {
      fileURL.appendingPathComponent(filename)
   }
   
   public func fileURL(fileName: String, extension anExtension: String) -> URL {
      fileURL.appendingPathComponent(fileName).appendingPathExtension(anExtension)
   }
   
   public func toNonExistendFilename(_ filename: String) -> String {
      guard !containsFile(named: filename) else { return filename }
      
      var index = 0
      var candidate = filename
      
      let components = filename.components(separatedBy: ".")
      
      if components.count > 1 {
         let pureFilename = filename.components(separatedBy: ".").first!
         let fileExtension = filename.components(separatedBy: ".").last!
         
         while containsFile(named: candidate) {
            index += 1
            candidate = "\(pureFilename)_\(index).\(fileExtension)"
         }
      } else {
         while containsFile(named: candidate) {
            index += 1
            candidate = "\(filename)_\(index)"
         }
      }
      
      return candidate
   }
   
   public func directory(named name: String, create: Bool = false) -> Directory {
      let directory = Directory(at: self.fileURL.appendingDirectoryComponent(name))
      if create { try? directory.create() }
      return directory
   }
   
   public func directoryURL(named name: String, create: Bool = false) -> URL {
      let directoryURL = self.fileURL.appendingDirectoryComponent(name)
      if create { try? Directory(at: directoryURL).create() }
      return directoryURL
   }
   
   public func containsFile(named filename: String) -> Bool {
      return self.fileURL.appendingPathComponent(filename).exists
   }
}
