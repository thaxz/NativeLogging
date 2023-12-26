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
    ///   - file: The name of the file in which the log message originated.
    ///   - function: The name of the function in which the log message originated.
    ///   - line: The line number at which the log message originated.
    static func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(level: .info, message: message, file: file, function: function, line: line)
    }
    
    static func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(level: .warning, message: message, file: file, function: function, line: line)
    }
    
    static func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        handleLog(level: .error, message: message, file: file, function: function, line: line)
    }
    
    fileprivate static func handleLog(level: LogLevel, message: String, file: String, function: String, line: Int) {
        let context = LogContext(file: file, function: function, line: line)
        let logComponents = ["[\(level.prefix)]", "\(context.description)", "Message: \(message)"]
        
        let fullString = logComponents.joined(separator: "\n")
        
        os_log("%{public}@", log: log, type: level.logType, fullString)
        saveLogToFile(message: fullString)
        
        // Debug prints
        print("Logged: \(fullString)")
    }
    
    /// Creates the file if it does not exist.
    private static func createFileIfNeeded(at fileURL: URL) {
        guard !FileManager.default.fileExists(atPath: fileURL.path) else { return }
        do {
            try "".write(to: fileURL, atomically: false, encoding: .utf8)
            print("Log file created successfully.")
        } catch {
            print("Error creating log file: \(error)")
        }
    }
    
    /// Saves a log message to a local file.
    ///
    /// - Parameter message: The log message to be saved.
    private static func saveLogToFile(message: String) {
        let fileName = "app_logs.txt"
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let logFileURL = documentDirectory.appendingPathComponent(fileName)
        createFileIfNeeded(at: logFileURL)
        performFileCleanupIfNeeded(fileURL: logFileURL)
        do {
            // Read the current content of the file
            var currentContent = try String(contentsOf: logFileURL, encoding: .utf8)
            // Append the new log
            currentContent.append("\(message)\n")
            // Write the updated content back to the file
            try currentContent.write(to: logFileURL, atomically: false, encoding: .utf8)
            print("Log added successfully.")
        } catch {
            print("Error adding log: \(error)")
        }
    }
    
    /// Checks if a file cleanup is needed and performs it if necessary.
    ///
    /// - Parameter fileURL: The URL of the file to be checked and cleaned.
    private static func performFileCleanupIfNeeded(fileURL: URL) {
        let currentDate = Date()
        // Check if more than 5 days have passed since the last cleanup
        if let lastCleanDate = UserDefaults.standard.value(forKey: "lastCleanDate") as? Date,
           currentDate.timeIntervalSince(lastCleanDate) > 5 * 24 * 60 * 60 {
            clearLogFile(fileURL: fileURL)
            // Update the last cleanup day
            UserDefaults.standard.set(currentDate, forKey: "lastCleanDate")
            print("Last clean date updated to \(currentDate)")
        }
    }
    
    /// Clears the contents of the specified local log file.
    private static func clearLogFile(fileURL: URL) {
        do {
            try "".write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print("Error clearing log file: \(error)")
        }
    }
    
}
