//
//  Context.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import Foundation

// To know the file, the line and the context of the log
struct LogContext {
    let file: String
    let function: String
    let line: Int
    var description: String {
        return "\((file as NSString).lastPathComponent):\(line) \(function)"
    }
}
