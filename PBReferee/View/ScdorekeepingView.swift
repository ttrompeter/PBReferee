//
//  ScorekeepingView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/19/22.
//

import RealmSwift
import SwiftUI

struct ScorekeepingView: View {
    
    @ObservedRealmObject var match: Match
    @State private var isStartApp = false
    
    var body: some View {
        
        VStack (spacing: 10) {
            Text("Scorekeeping In Pickleball Referee")
                .padding(10)
                .font(.largeTitle)
                .foregroundColor(Constants.DARK_SLATE)
            
            Text("The Pinochle Referee App automates many parts of the scorekeeping so the referee can focus on managing the match. Whenever the referee awards a point by tapping the Point button the App calcualtes the new score and displays it. When a first server loses a rally, the referee should tap the 2nd Server button and the score will now be kept for that player and a Side Out button will be displayed. When a second server loses a rally, the referee should tap the Side Out button and the display will change to the other team with its firt server serving. And so on until the match is completed.")
            
                .font(.headline)
                .multilineTextAlignment(.leading)
                .foregroundColor(Constants.DARK_SLATE)
            
            
            VStack (alignment: .leading) {
                Group {
                    Text("")
                    Text("Key Components of Pickleball Referee")
                    HStack (alignment: .top) {
                        Text("\u{2022}  ")
                        Text("The App centers around the Pickleball Match Scoresheet page. This is where most of the work is done. This scoresheet looks just like the physical scoresheet used when manually keeping score.")
                    }
                    HStack (alignment: .top) {
                        Text("\u{2022}  ")
                        Text("Buttons on the side of the Scoresheet page provide access to most functinality. There are also buttons and links within the Scoresheet page. Key buttons are the Briefing button for the pre-match briefing, the Timeout button for timeouts")
                    }
                    HStack (alignment: .top) {
                        Text("\u{2022}  ")
                        Text("A Match Setup page is used to enter data such as player names, court number, match numbere, officials names, starting servers and more. The scoresheet will not be fully functional until the match setup is completed; i.e. buttons will be disabled.")
                    }
                    HStack (alignment: .top) {
                        Text("\u{2022}  ")
                        Text("When ready to start the match tap the 'Start Match' button. Then the appropriate features will be activated.")
                    }
                    HStack (alignment: .top) {
                        Text("\u{2022}  ")
                        Text("The Briefing Button displays a popup sheet containing a checklist for the Pre-match briefing with the players. The Coin Toss button to generates a random number (1 or 2) to select first server and side of court.")
                    }
                    HStack (alignment: .top) {
                        Text("\u{2022}  ")
                        Text("The Point button calcuates the score and displays the updated score when a point is scored.")
                    }
                    HStack (alignment: .top) {
                        Text("\u{2022}  ")
                        Text("To change ther server tap the 2nd Server button or the Side Out button as appropriate.")
                    }
                }
                
                HStack (alignment: .top) {
                    Text("\u{2022}  ")
                    Text("Tap the Side Out button when the second server loses the rally. The dispaly will change to the next team serving as first server. The scoresheet will be marked with a sideout colored vertical line at the appropraite point.")
                }
                HStack (alignment: .top) {
                    Text("\u{2022}  ")
                    Text("The App will notify theuser when the game and match are completed. This is based on the match settings; i.e. best 2 of 3 games.")
                }
                HStack (alignment: .top) {
                    Text("\u{2022} ")
                    Text("When play is completed, take a screenshot of the scoresheet (using the link supplied). The scoresheet can then be printed or emailed in Admin : Screenshot.")
                }
                HStack (alignment: .top) {
                    Text("\u{2022} ")
                    Text("When match is over, tap the End Match button. The App will be reset and be ready to setup the next match.")
                }
            }
            .font(.subheadline)
            .multilineTextAlignment(.leading)
            .foregroundColor(Constants.DARK_SLATE)
            
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

struct ScorekeepingView_Previews: PreviewProvider {
    static var previews: some View {
        ScorekeepingView(match: Match())
    }
}

