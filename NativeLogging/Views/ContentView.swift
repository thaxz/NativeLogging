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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear{
                    Logger.info("This is an info entry")
                    Logger.warning("This is a warning")
                    Logger.error("This is an error")
                }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
