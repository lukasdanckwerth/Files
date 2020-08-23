//
//  Directory.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 09.10.19.
//  Copyright © 2019 WinValue. All rights reserved.
//

import Foundation

open class Directory: Location {
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Properties
   // ===-----------------------------------------------------------------------------------------------------------===
   
   public var fileURL: URL
   
   
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Initialization
   // ===-----------------------------------------------------------------------------------------------------------===
   
   required public init(at path: String) {
      self.fileURL = URL(fileURLWithPath: path)
   }
   
   required public init(at url: URL) {
      self.fileURL = url
   }
   
   required public init?(at directoryURL: URL, create: Bool) {
      self.fileURL = directoryURL
      guard create else { return }
      do {
         try self.create()
      } catch {
         NSLog(error.localizedDescription)
         return nil
      }
   }
   
   public var size: Int64 {
      var size: Int64 = 0
      for fileURL in self.contents {
         size += fileURL.size
      }
      return size
   }
}

extension Directory {
   
   // ===-----------------------------------------------------------------------------------------------------------===
   //
   // MARK: - Default URLs
   // ===-----------------------------------------------------------------------------------------------------------===
   
   /// Reference to the app's document directory (`"~"`)
   public static var home: Directory {
      return Directory(at: .home)
   }
   
   /// Reference to the app's tmp directory (`"../tmp"`)
   public static var temporary: Directory {
      return Directory(at: .temporary)
   }
   
   /// Reference to the app's library directory (`"../Library"`)
   public static var library: Directory {
      return Directory(at: .library)
   }
   
   /// Reference to the app's preferences directory (`"../Library/Preferences"`)
   public static var preferences: Directory {
      return Directory(at: .preferences)
   }
   
   /// Reference to the app's library support directory (`"../Library/Application Support"`)
   public static var librarySupport: Directory {
      return Directory(at: .librarySupport)
   }
   
   /// Reference to the app's document directory (`"../Documents"`)
   public static var documents: Directory {
      return Directory(at: .documentsDirectoryURL)
   }
}
