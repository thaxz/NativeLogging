//
//  LogLevel.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import Foundation
import os.log

enum LogLevel {
    
    case info
    case warning
    case error
    
    /// Prefix associated with each log level.
    var prefix: String {
        switch self {
        case .info:
            return "🗒️ INFO"
        case .warning:
            return "⚠️ WARNING"
        case .error:
            return "❌ ERROR"
        }
    }
    
    /// Log type associated with each log level.
    var logType: OSLogType {
        switch self {
        case .info:
            return .info
        case .warning:
            return .default
        case .error:
            return .error
        }
    }
}
