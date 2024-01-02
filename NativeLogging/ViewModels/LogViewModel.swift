//
//  LogViewModel.swift
//  NativeLogging
//
//  Created by thaxz on 02/01/24.
//

import Foundation

class LogViewModel: ObservableObject {
    
    func getPath(){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print("Document Directory: \(documentDirectory.path)")
        }
    }
    
    func sendLogs(){
        
    }
    
    
    
}
