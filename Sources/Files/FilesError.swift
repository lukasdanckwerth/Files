//
//  FilesError.swift
//  Files
//
//  Created by Lukas on 29.12.20.
//

import Foundation

/// Error type thrown by all of Files' throwing APIs.
public struct FilesError<Reason>: Error {
    
    /// The `Location` that the error occured at.
    public var location: Location
    /// The reason that the error occured.
    public var reason: Reason
    
    /// Creates a new instance with a `Location` and a reason.
    ///
    /// - parameter location: The `Location` that the error occured at.
    /// - parameter reason: The reason that the error occured.
    public init(location: Location, reason: Reason) {
        self.location = location
        self.reason = reason
    }
}

extension FilesError: CustomStringConvertible {
    public var description: String {
        return """
        Files encountered an error at '\(location)'.
        Reason: \(reason)
        """
    }
}

public enum LocationErrorReason {
    case notExisting
}

typealias LocationError = FilesError<LocationErrorReason>
