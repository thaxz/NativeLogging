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
                    Log.info("This is an info entry")
                    Log.warning("This is a warning")
                    Log.error("This is an error")
                }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
