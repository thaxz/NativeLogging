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
    let date: Date
    
    /// A formatted string containing file, line, and function information.
    var description: String {
            return """
            File: \((file as NSString).lastPathComponent)
            Line: \(line)
            Function: \(function)
            Date: \(date)
            """
        }
}
