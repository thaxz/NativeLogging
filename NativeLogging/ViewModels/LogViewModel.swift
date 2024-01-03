//
//  LogViewModel.swift
//  NativeLogging
//
//  Created by thaxz on 02/01/24.
//

import Foundation
import Alamofire

class LogViewModel: ObservableObject {
    
    /// Getting file's path to verify if every log is being saved
    func getPath(){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print("Document Directory: \(documentDirectory.path)")
        }
    }
    
    /// Sends logs to the server
    func sendLogs() {
        // Getting file url inside document directory
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document directory is nil")
            return }
        let logFileURL = documentDirectory.appendingPathComponent(Constants.shared.fileName)
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
        let mockUrl = URL(string: "https://postb.in/b/1704225012265-7183685568161")!
        // Uploading file
        AF.upload(
            multipartFormData: { multipartFormData in
                /// Uncomment to add the user token to the logs
                //multipartFormData.append(token.data(using: .utf8)!, withName: "token")
                multipartFormData.append(logFileURL, withName: "uploadedFile", fileName: Constants.shared.fileName, mimeType: "text/plain")
            },
            to: mockUrl,
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
