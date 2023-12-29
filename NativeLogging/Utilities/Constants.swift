//
//  Constants.swift
//  NativeLogging
//
//  Created by thaxz on 27/12/23.
//

import Foundation

class Constants {
    
    static let shared = Constants()
    private init () {}
    
    /// Time for the Logs file to be cleaned, currently corresponds to five days
    var cleanTimeInSeconds: Double {
        return 5 * 24 * 60 * 60
    }
    
    /// Specify Log file name
    let fileName = "app_logs.txt"
    /// Key to access file's last clean date
    let lastCleanDateKey = "lastCleanDate"
}
