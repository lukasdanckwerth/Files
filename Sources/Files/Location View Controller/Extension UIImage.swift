//
//  Extension UIImage.swift
//  FileKit
//
//  Created by Lukas Danckwerth on 21.03.20.
//  Copyright © 2020 Lukas Danckwerth. All rights reserved.
//

#if canImport(UIKit)
import UIKit.UIImage

public extension UIImage {
    /// Creates a new instance from the image at the given `URL`.
    ///
    convenience init?(url: URL) {
        self.init(contentsOfFile: url.path)
    }
}
#endif
