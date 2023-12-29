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
    
    var cleanTimeInSeconds: Double {
        return 5 * 24 * 60 * 60
    }
    
    // Specify Log file name
    let fileName = "app_logs.txt"
    let lastCleanDateKey = "lastCleanDate"
}
