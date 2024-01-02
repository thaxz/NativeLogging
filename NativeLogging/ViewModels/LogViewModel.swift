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
    
    func sendLogs() {
        // Handle the case where documentDirectory is nil
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let logFileURL = documentDirectory.appendingPathComponent(Constants.shared.fileName)
        
        // Handle the case if the log file doesn't exist
        guard FileManager.default.fileExists(atPath: logFileURL.path) else { return }
        
        guard let token = UserDefaults.standard.string(forKey: Constants.shared.token) else {return}
        let url = URL(string: "server_upload_url")!  // Replace with upload URL
        
    }
    
}
