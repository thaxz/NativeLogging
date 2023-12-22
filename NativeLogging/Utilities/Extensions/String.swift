//
//  String.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import Foundation

extension String {
    
    /// Appends the string to the specified file URL.
    func appendToURL(fileURL: URL) throws {
        try self.appendLineToURL(fileURL: fileURL)
    }
    
    /// Appends a line with the string to the specified file URL.
    private func appendLineToURL(fileURL: URL) throws {
        try self.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
    }
}
