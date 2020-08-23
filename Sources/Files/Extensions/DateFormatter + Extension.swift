//
//  File 2.swift
//  
//
//  Created by Lukas on 02.08.20.
//

import Foundation

public extension DateFormatter {
   
   
   // MARK: - Statics
   
   /// With date format `"yyyy-MM-dd"`.
   static let simpleDate: DateFormatter = .from(dateFormat: "yyyy-MM-dd")
   
   /// With date format `"yyyyMMdd_hhmmss"`.
   static let full: DateFormatter = .from(dateFormat: "yyyyMMdd_hhmmss")
   
   /// With date format `"EEE, hh:mm:ss.SS"`.
   static let logger: DateFormatter = .from(dateFormat: "hh:mm:ss.SS")
   
   /// With date format `"yyyy-MM-dd-HHmmss"`.
   static let backupFilePrefix: DateFormatter = .from(dateFormat: "yyyy-MM-dd-HHmmss")
   
   
   /// Convenient function to create a `DateFormatter` with the given date format.
   private static func from(dateFormat: String) -> DateFormatter {
      let f = DateFormatter()
      f.dateFormat = dateFormat
      return f
   }
}
