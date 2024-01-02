//
//  LogViewModel.swift
//  NativeLogging
//
//  Created by thaxz on 02/01/24.
//

import Foundation
import Alamofire

class LogViewModel: ObservableObject {
    
    // debug: getting file's path to verify if every log is being saved
    func getPath(){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print("Document Directory: \(documentDirectory.path)")
        }
    }
    
    func sendLogs() {
        // Handle the case where documentDirectory is nil
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document directory is nil")
            return }
        
        let logFileURL = documentDirectory.appendingPathComponent(Constants.shared.fileName)
        
        // Handle the case if the log file doesn't exist
        guard FileManager.default.fileExists(atPath: logFileURL.path) else {
            print("The file path is nil")
            return }
        
        //Uncomment to add the user token to the logs
        /*
         guard let token = UserDefaults.standard.string(forKey: Constants.shared.token) else {
         print("Token not found")
         return
         }
         */
        
        let url = URL(string: "server_upload_url")!  // Replace with upload URL
        AF.upload(
            multipartFormData: { multipartFormData in
                /// Uncomment to add the user token to the logs
                //multipartFormData.append(token.data(using: .utf8)!, withName: "token")
                multipartFormData.append(logFileURL, withName: "uploadedFile", fileName: Constants.shared.fileName, mimeType: "text/plain")
            },
            to: url,
            method: .post)
        .response { response in
            switch response.result {
            case .success:
                print("Log upload successful.")
            case .failure(let error):
                print("Log upload failed with error: \(error)")
            }
        }
    }
}