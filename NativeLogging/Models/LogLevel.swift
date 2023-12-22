//
//  LogLevel.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import Foundation

enum LogLevel {
    case info
    case warning
    case error
   
    var prefix: String {
        switch self {
        case .info:
            return "INFO"
        case .warning:
            return "⚠️ WARNING"
        case .error:
            return "❌ ERROR"
        }
    }
}
