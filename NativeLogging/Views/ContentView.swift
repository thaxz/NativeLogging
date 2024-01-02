//
//  ContentView.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: LogViewModel = LogViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            Button("Add info entry") {
                Logger.info("This is an info entry with some JSON response")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            Button("Add warning entry") {
                Logger.warning("This is a warning entry with some JSON response")
            }
            .buttonStyle(.borderedProminent)
            .tint(.yellow)
            Button("Add error entry") {
                Logger.error("This is an error entry with some JSON response")
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            Spacer()
            Button("Send Logs") {
                print("apertei o botão")
                viewModel.sendLogs()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
