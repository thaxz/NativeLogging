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
    
    var fiveDaysInSeconds: Double {
        return 5 * 24 * 60 * 60
    }
    
    let lastCleanDateKey = "lastCleanDate"
}
