//
//  Context.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import Foundation

/// Struct representing context information (file, function, line) for a log message.
struct LogContext {
    
    let file: String
    let function: String
    let line: Int
    
    /// A formatted string containing file, line, and function information.
    var description: String {
        return "\((file as NSString).lastPathComponent):\(line) \(function)"
    }
}
