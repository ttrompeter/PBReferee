//
//  IntroductionOverviewView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/19/22.
//

import RealmSwift
import SwiftUI

struct IntroductionOverviewView: View {
    
    @ObservedRealmObject var match: Match
    @State private var isStartApp = false
    
    var body: some View {
        
        VStack (spacing: 20) {
            Text("Introduction To Pickleball Referee")
                .padding(10)
                .font(.largeTitle)
                .foregroundColor(Constants.DARK_SLATE)
                .foregroundColor(Constants.DARK_SLATE)
            
            Text("The Pinochle Referee App is designed to supplant manual scoresheets used by referees of pickleball matches. It not only provides an electronic representation of the manual scoresheet, it also includes functionality to automate the scorekeeping process and avoids many of the errors of manual scorekeeping. Most of the features are intuitive, but learning all the features and understanding how the App works will result in a much better user experience. Please consult the Help pages for detailed information about using Pickleball Referee.")
            
                .font(.headline)
                .multilineTextAlignment(.leading)
                .foregroundColor(Constants.DARK_SLATE)
                //.frame(width: 800)
            
            ZStack {
                Rectangle()
                    .frame(width: CGFloat(820), height: CGFloat(210))
                    .foregroundColor(Constants.CLOUDS)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Text("""
                Features:
                \u{2022} Keeps score automatically when points are scored.
                \u{2022} Keeps track of points by player and team.
                \u{2022} Can be used for Singles and Doubles matches.
                \u{2022} Scores all types of games: best 2 of 3 games, best 3 o 5 games, and single games.
                \u{2022} Provides helpful information for pre-match briefing, time outs, and end of game and match.
                \u{2022} Customizable for many of your inidvidual preferences.
                """)
                .font(.subheadline)
                .foregroundColor(Constants.ELECTRON_BLUE)
            }
            
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
                
//                HStack (alignment: .top) {
//                    Text("\u{2022}  ")
//                    Text("Tap the Side Out button when the second server loses the rally. The dispaly will change to the next team serving as first server. The scoresheet will be marked with a sideout colored vertical line at the appropraite point.")
//                }
//                HStack (alignment: .top) {
//                    Text("\u{2022}  ")
//                    Text("The App will notify theuser when the game and match are completed. This is based on the match settings; i.e. best 2 of 3 games.")
//                }
//                HStack (alignment: .top) {
//                    Text("\u{2022} ")
//                    Text("When play is completed, take a screenshot of the scoresheet (using the link supplied). The scoresheet can then be printed or emailed in Admin : Screenshot.")
//                }
//                HStack (alignment: .top) {
//                    Text("\u{2022} ")
//                    Text("When match is over, tap the End Match button. The App will be reset and be ready to setup the next match.")
//                }
            }
            .padding(.horizontal, 60)
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

struct IntroductionOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionOverviewView(match: Match())
    }
}

