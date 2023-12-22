//
//  Logger.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import Foundation

/// A class for logging messages with different log levels.
class Logger {
   
    // Literal expressions
    /// #file = the path to the file in which it appears
    /// #line = the line number on which it appears
    /// #function = the name of the declaration in which it appears
    // Vai pegar todos esses valores ^ do lugar que essa função estiver sendo chamada
    static func info(_ string: StaticString, shouldShowContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line){
        let context = LogContext(file: file, function: function, line: line)
        Logger.handleLog(level: .info, string: string.description, shouldLogContext: shouldShowContext, context: context)
    }
   
    static func warning(_ string: StaticString, shouldShowContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line){
        let context = LogContext(file: file, function: function, line: line)
        Logger.handleLog(level: .warning, string: string.description, shouldLogContext: shouldShowContext, context: context)
    }
   
    static func error(_ string: StaticString, shouldShowContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line){
        let context = LogContext(file: file, function: function, line: line)
        Logger.handleLog(level: .error, string: string.description, shouldLogContext: shouldShowContext, context: context)
    }
   
    // Handling log and formatting what is going to be printed
    fileprivate static func handleLog(level: LogLevel, string: String, shouldLogContext: Bool, context: LogContext){
       
        let logComponents = ["[\(level.prefix)]", "\n", string]
       
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext {
            fullString += "\n \(context.description)"
        }
        // Change this bc it only works on development mode
        #if DEBUG
        print(fullString)
        #endif
       
    }
   
}
