//
//  ExtensionEncodable.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 11.01.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation

extension Encodable where Self: Decodable {
   
   
   /// Returns a copy of this `Codable`.  The copy is created by decoding and encoding this `Codable` to and from `Data`.
   var copy: Self? {
      do {
         return try JSONDecoder().decode(Self.self, from: JSONEncoder().encode(self))
      } catch let error {
         NSLog("Can't copy \(self).  \(error)")
      }
      return nil
   }
}
