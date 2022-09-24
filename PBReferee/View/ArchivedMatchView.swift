//
//  ArchivedMatchView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/2/22.
//

import RealmSwift
import SwiftUI

struct ArchivedMatchView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var archivedMatch: ArchivedMatch
    
    var body: some View {
        VStack {
            Text(archivedMatch.eventTitle)
                .font(.title)
                .padding()
                .foregroundColor(Constants.MINT_LEAF)
            
            ZStack {
                Rectangle()
                    .frame(width: CGFloat(540), height: CGFloat(120))
                    .foregroundColor(Constants.CLOUDS)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                VStack (alignment: .leading){
                   
                    HStack {
                        Text("Match Number: \(archivedMatch.matchNumber)")
                        Text("Match Date: \(archivedMatch.matchDate, style: .date)")
                    }
                    Text("Match Final Score: \(archivedMatch.finalMatchScore)")
                    Text("Final Game Scores: \(archivedMatch.finalGameScores)")
                    HStack {
                        Text("Team 1: ")
                        Text("\(archivedMatch.namePlayer1Team1)  |  \(archivedMatch.namePlayer2Team1)")
                    }
                    HStack {
                        Text("Team 2: ")
                        Text("\(archivedMatch.namePlayer1Team2)  |  \(archivedMatch.namePlayer2Team2)")
                    }
                }
                .font(.body)
                .foregroundColor(Constants.MINT_LEAF)
            }
            
            TabView {
                ScoresheetImageView()
                    .tabItem {
                        Label("Scoresheet", systemImage: "list.bullet.rectangle.fill")
                    }
                StatisticsImageView()
                    .tabItem {
                        Label("Statistics", systemImage: "list.bullet.rectangle.fill")
                    }
            }
            Spacer()
            HStack (spacing: 40) {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 20)
        } // End Top VStack
    }
}

struct ArchivedMatchView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedMatchView(archivedMatch: ArchivedMatch())
    }
}



