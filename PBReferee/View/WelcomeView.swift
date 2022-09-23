//
//  WelcomeView.swift
//  PBReferee
//
//  Created by Tom Trompeter on 9/23/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("Gaday, universe")
                .font(.largeTitle)
                .foregroundColor(.cyan)
            
            Image(systemName: "globe.americas")
                .imageScale(.large)
                .foregroundColor(.accentColor)
        }
        .padding()
    }
}

