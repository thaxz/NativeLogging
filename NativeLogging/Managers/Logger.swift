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
        // Creates a LogContext with the function parameters
        let context = LogContext(file: file, function: function, line: line)
        // Assemble the log components
        let logComponents = ["[\(level.prefix)]", "\(context.description)", "Message: \(message)"]
        let fullString = logComponents.joined(separator: "\n")
        // Log the full string using the OSLog system
        os_log("%{public}@", log: log, type: level.logType, fullString)
        // Saves the log to a local file
        saveLogToFile(message: fullString)
        print("Logged: \(fullString)")
    }
    
    /// Creates the file if it does not exist.
    private static func createFileIfNeeded(at fileURL: URL) {
        // Check if the file already exists
        guard !FileManager.default.fileExists(atPath: fileURL.path) else { return }
        do {
            // Creates the file by writing an empty string
            try "".write(to: fileURL, atomically: false, encoding: .utf8)
            print("Log file created successfully.")
            // Set the initial last clean date
            let currentDate = Date()
            UserDefaults.standard.set(currentDate, forKey: Constants.shared.lastCleanDateKey)
            print("Initial last clean date set to \(currentDate)")
        } catch {
            print("Error creating log file: \(error)")
        }
    }
    
    /// Saves a log message to a local file.
    ///
    /// - Parameter message: The log message to be saved.
    private static func saveLogToFile(message: String) {
        // Specify the file name
        let fileName = "app_logs.txt"
        // Get the URL for the file
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let logFileURL = documentDirectory.appendingPathComponent(fileName)
        // Create if it does not exist
        createFileIfNeeded(at: logFileURL)
        // Cleans the file if enough time has been passed
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
        // Get the current date and retrieve the last clean date
        let currentDate = Date()
        guard let lastCleanDate = UserDefaults.standard.value(forKey: Constants.shared.lastCleanDateKey) as? Date else { return }
        // Calculate the time interval since the last cleanup
        let timeIntervalSinceLastClean = currentDate.timeIntervalSince(lastCleanDate)
        // Check if more than 5 days have passed
        if timeIntervalSinceLastClean > Constants.shared.fiveDaysInSeconds {
            clearLogFile(fileURL: fileURL)
            // Update the last clean date
            UserDefaults.standard.set(currentDate, forKey: Constants.shared.lastCleanDateKey)
            print("Last clean date updated to \(currentDate)")
        } else {
            print("Not enough time has passed since the last cleanup")
        }
    }
    
    /// Clears the contents of the specified local log file.
    private static func clearLogFile(fileURL: URL) {
        do {
            // Cleaning the Log file by writing an empty string
            try "".write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print("Error clearing log file: \(error)")
        }
    }
    
}
