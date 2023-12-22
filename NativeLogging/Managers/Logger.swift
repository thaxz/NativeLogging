//
//  Logger.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import Foundation
import os.log

/// A class for logging messages with different log levels.
class Logger {
    
    private static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Network")
    
    /// Logs an informational message.
    /// - Parameters:
    ///   - message: The message to be logged.
    ///   - shouldShowContext: Indicates whether context information (file, function, line) should be included in the log.
    ///   - file: The name of the file in which the log message originated.
    ///   - function: The name of the function in which the log message originated.
    ///   - line: The line number at which the log message originated.
    static func info(_ message: String, shouldShowContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(level: .info, message: message, shouldLogContext: shouldShowContext, file: file, function: function, line: line)
    }
    
    static func warning(_ message: String, shouldShowContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(level: .warning, message: message, shouldLogContext: shouldShowContext, file: file, function: function, line: line)
    }
    
    static func error(_ message: String, shouldShowContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(level: .error, message: message, shouldLogContext: shouldShowContext, file: file, function: function, line: line)
    }
    
    fileprivate static func handleLog(level: LogLevel, message: String, shouldLogContext: Bool, file: String, function: String, line: Int) {
        
        let context = LogContext(file: file, function: function, line: line)
        let logComponents = ["[\(level.prefix)]", message]
        
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext {
            fullString += " \(context.description)"
        }
        
        os_log("%{public}@", log: log, type: level.logType, fullString)
        saveLogToFile(message: fullString)
        
        // Debug prints
        print("Logged: \(fullString)")
        
    }
    
    /// Saves a log message to a local file.
    ///
    /// - Parameter message: The log message to be saved.
    private static func saveLogToFile(message: String) {
        
        let fileName = "app_logs.txt"
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let logFileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try "\(message)\n".appendToURL(fileURL: logFileURL)
        } catch {
            print("Error saving log to file: \(error)")
        }
    }
    
}
