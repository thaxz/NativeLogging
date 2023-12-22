//
//  ContentView.swift
//  NativeLogging
//
//  Created by thaxz on 22/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Add info entry") {
                Logger.info("This is an info entry")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            Button("Add warning entry") {
                Logger.info("This is a warning")
            }
            .buttonStyle(.borderedProminent)
            .tint(.yellow)
            Button("Add error entry") {
                Logger.info("This is an error")
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
