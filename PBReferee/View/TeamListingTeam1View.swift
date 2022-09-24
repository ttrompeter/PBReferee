//
//  TeamListingTeam1.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

struct TeamListingTeam1View: View {
    
    @ObservedRealmObject var match: Match
    
    var body: some View {
        
        HStack {
            HStack {
                Text("Team 1:   ")
                    .foregroundColor(Constants.DARK_SLATE)
                
                if match.games[match.currentGameArrayIndex].selectedFirstServerTeam1 == 1 {
                    HStack {
                        if match.servingPlayerNumber == 1 {
                            Image("exclamation")
                                .resizable()
                                .frame(width: 4, height: 20)
                                .clipped()
                        }
                        Text("   \(match.namePlayer1Team1)   ")
                            .foregroundColor(Constants.MINT_LEAF)
                    }
                } else {
                    HStack {
                        if match.servingPlayerNumber == 1 {
                            Image("exclamation")
                                .resizable()
                                .frame(width: 4, height: 20)
                                .clipped()
                        }
                        Text("   \(match.namePlayer1Team1)   ")
                            .foregroundColor(Constants.DARK_SLATE)
                    }
                }
            }
            .font(.headline)
            
            Text("[ \(match.player1Team1Identifiers) ]")
                .italic()
                .font(.subheadline)
                .foregroundColor(Constants.SLATE_GRAY)
            Text("     ||     ")
                .font(.headline)
                .foregroundColor(Constants.DARK_SLATE)
            
            if match.games[match.currentGameArrayIndex].selectedFirstServerTeam1 == 2 {
                HStack {
                    if match.servingPlayerNumber == 2 {
                        Image("exclamation")
                            .resizable()
                            .frame(width: 4, height: 20)
                            .clipped()
                    }
                    Text("\(match.namePlayer2Team1)   ")
                        .font(.headline)
                        .foregroundColor(Constants.MINT_LEAF)
                }
            } else {
                HStack {
                    if match.servingPlayerNumber == 2 {
                        Image("exclamation")
                            .resizable()
                            .frame(width: 4, height: 20)
                            .clipped()
                    }
                    Text("\(match.namePlayer2Team1)   ")
                        .font(.headline)
                        .foregroundColor(Constants.DARK_SLATE)
                }
            }
            
            Text("[ \(match.player2Team1Identifiers) ]")
                .italic()
                .font(.subheadline)
                .foregroundColor(Constants.SLATE_GRAY)
        }
        .padding(10)
        .background(Constants.CLOUDS)
    }
}

//struct TeamListingTeam1_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamListingTeam1()
//    }
//}

