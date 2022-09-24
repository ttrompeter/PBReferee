//
//  QuickstartView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/19/22.
//

import RealmSwift
import SwiftUI

struct QuickstartView: View {
    
    @ObservedRealmObject var match: Match
    @State private var isStartApp = false
    
    var body: some View {
        
        VStack (spacing: 10) {
            Text("Quickstart For Pickleball Referee")
                .padding(10)
                .font(.largeTitle)
                .foregroundColor(Constants.DARK_SLATE)
            
            Text("This quickstart highlights the basics of using the App to referee a pickleball match. Please explore all the features of the App to enjoy the full benefits of the app and make refereeing a pickleball match as easy and accurate a possible.")
            
                .font(.headline)
                .multilineTextAlignment(.leading)
                .foregroundColor(Constants.DARK_SLATE)
            
            
            VStack (alignment: .leading, spacing: 20) {
                Group {
                    Text("")
                    Text("Basics of Using Pickleball Referee")
                    HStack (alignment: .top) {
                        Text("1.  ")
                        Text("The App centers around the Pickleball Match Scoresheet page. This is where most of the work is done.")
                    }
                    HStack (alignment: .top) {
                        Text("2.  ")
                        Text("A list of buttons on the side of the Scoresheet page provide access to most functinality. There are also buttons and links within the Scoresheet page. Key buttons are the Briefing button for the pre-match briefing, the Timeout button for timeouts")
                    }
                    HStack (alignment: .top) {
                        Text("3.  ")
                        Text("Before starting a match, use Match Setup to enter data such as player names, court number, match numbere, officials names, starting servers and more. You will not be able to fuly use the scoresheet until the match setup is completed; i.e. buttons will be disabled.")
                    }
                    HStack (alignment: .top) {
                        Text("4.  ")
                        Text("When ready to start the match tap the 'Start Match' button. Then the appropriate features will be activated.")
                    }
                    HStack (alignment: .top) {
                        Text("5.  ")
                        Text("Tap the Briefing Button to see a popup sheet for the Pre-match birefing with the players. Also, use the Coin Toss button to generate a random number (1 or 2) to select first server and side of court.")
                    }
                    HStack (alignment: .top) {
                        Text("6.  ")
                        Text("During play tap the Point button when a point is scored. The App will calcuate the score and display the updated score.")
                    }
                    HStack (alignment: .top) {
                        Text("7.  ")
                        Text("Tap 2nd Server button when the first server losing the rally. The 2nd Server button will change to a Side Out button.")
                    }
                }
                
                HStack (alignment: .top) {
                    Text("8.  ")
                    Text("Tap the Side Out button when the second server loses the rally. The dispaly will change to the next team serving as first server. The scoresheet will be marked with a sideout colored vertical line at the appropraite point.")
                }
                HStack (alignment: .top) {
                    Text("9.  ")
                    Text("The App will notify theuser when the game and match are completed. This is based on the match settings; i.e. best 2 of 3 games.")
                }
                HStack (alignment: .top) {
                    Text("10. ")
                    Text("When play is completed, take a screenshot of the scoresheet (using the link supplied). The scoresheet can then be printed or emailed in Admin : Screenshot.")
                }
                HStack (alignment: .top) {
                    Text("11. ")
                    Text("When match is over, tap the End Match button. The App will be reset and be ready to setup the next match.")
                }
            }
            .padding(.horizontal, 60)
            .font(.headline)
            .multilineTextAlignment(.leading)
            .foregroundColor(Constants.ELECTRON_BLUE)
            
            
            Spacer()
            
            VStack {
                // TODO: - Need Home View
//                NavigationLink (destination: HomeView(match: match), isActive: $isStartApp) {
//                }
                Button("Start App") {
                    isStartApp = true
                }
                .buttonStyle(WelcomeButtonStyle())
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct QuickstartView_Previews: PreviewProvider {
    static var previews: some View {
        QuickstartView(match: Match())
    }
}

