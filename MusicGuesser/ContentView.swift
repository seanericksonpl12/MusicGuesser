//
//  ContentView.swift
//  MusicGuesser
//
//  Created by Sean Erickson on 7/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Music Guesser")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                NavigationLink(destination: MainView()) {
                    Text("Start")
                }
                Spacer()
            }
            
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
