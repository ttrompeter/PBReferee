//
//  ViolationStatusView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/9/22.
//

import RealmSwift
import SwiftUI

struct ViolationStatusView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @EnvironmentObject var sheetManager: SheetManager
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var match: Match
    
    @State private var showingPopoverW1 = false
    @State private var showingPopoverW2 = false
    @State private var showingPopoverW3 = false
    @State private var showingPopoverW4 = false
    @State private var showingPopoverTF1 = false
    @State private var showingPopoverTF2 = false
    @State private var showingPopoverTF3 = false
    @State private var showingPopoverTF4 = false
    
    @State private var player1TotalFouls = 0
    @State private var player2TotalFouls = 0
    @State private var player3TotalFouls = 0
    @State private var player4TotalFouls = 0
    @State private var player1TotalWarnings = 0
    @State private var player2TotalWarnings = 0
    @State private var player3TotalWarnings = 0
    @State private var player4TotalWarnings = 0
    
    @State private var popoverWPlayer1Display = ""
    @State private var popoverWPlayer2Display = ""
    @State private var popoverWPlayer3Display = ""
    @State private var popoverWPlayer4Display = ""
    @State private var popoverTFPlayer1Display = ""
    @State private var popoverTFPlayer2Display = ""
    @State private var popoverTFPlayer3Display = ""
    @State private var popoverTFPlayer4Display = ""
    
    
    var body: some View {
        
        HStack {
            VStack {
                Text("Violations Status")
                    .font(.title3)
                    .padding(.bottom, 6)
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("Player")
                        Divider()
                        Text("\(match.namePlayer1Team1): ")
                            .lineLimit(1)
                        Text("\(match.namePlayer2Team1): ")
                            .lineLimit(1)
                        Text("\(match.namePlayer1Team2): ")
                            .lineLimit(1)
                        Text("\(match.namePlayer2Team2): ")
                            .lineLimit(1)
                        Text(" ")
                    }
                    .frame(width: 240)
                    
                    VStack {
                        Text("Warnings")
                        Divider()
                        
                        Button("\(player1TotalWarnings)") {
                            showingPopoverW1 = true
                        }
                        .popover(isPresented: $showingPopoverW1) {
                            Text("\(popoverWPlayer1Display)")
                                .font(.headline)
                                .padding()
                        }
                        Button("\(player2TotalWarnings)") {
                            showingPopoverW2 = true
                        }
                        .popover(isPresented: $showingPopoverW2) {
                            Text("\(popoverWPlayer2Display)")
                                .font(.headline)
                                .padding()
                        }
                        Button("\(player3TotalWarnings)") {
                            showingPopoverW3 = true
                        }
                        .popover(isPresented: $showingPopoverW3) {
                            Text("\(popoverWPlayer3Display)")
                                .font(.headline)
                                .padding()
                        }
                        Button("\(player4TotalWarnings)") {
                            showingPopoverW4 = true
                        }
                        .popover(isPresented: $showingPopoverW4) {
                            Text("\(popoverWPlayer4Display)")
                                .font(.headline)
                                .padding()
                        }
                        Divider()
                    }
                    VStack {
                        Text("Technical Fouls")
                        Divider()
                        
                        Button("\(player1TotalFouls)") {
                            showingPopoverTF1 = true
                        }
                        .popover(isPresented: $showingPopoverTF1) {
                            Text("\(popoverTFPlayer1Display)")
                                .font(.headline)
                                .padding()
                        }
                        Button("\(player2TotalFouls)") {
                            showingPopoverTF2 = true
                        }
                        .popover(isPresented: $showingPopoverTF2) {
                            Text("\(popoverTFPlayer2Display)")
                                .font(.headline)
                                .padding()
                        }
                        Button("\(player3TotalFouls)") {
                            showingPopoverTF3 = true
                        }
                        .popover(isPresented: $showingPopoverTF3) {
                            Text("\(popoverTFPlayer3Display)")
                                .font(.headline)
                                .padding()
                        }
                        Button("\(player4TotalFouls)") {
                            showingPopoverTF4 = true
                        }
                        .popover(isPresented: $showingPopoverTF4) {
                            Text("\(popoverTFPlayer4Display)")
                                .font(.headline)
                                .padding()
                        }
                        Divider()
                    }
                }
                HStack (alignment: .top){
                    VStack {
                        
                    }
                    .frame(width: 240)
                    VStack (alignment: .trailing) {
                        Text("Click on a number above for details")
                            .font(.caption.italic())
                            .foregroundColor(Constants.MINT_LEAF)
                    }
                }
            }
        }
        .padding()
        .frame(width: 630)
        .foregroundColor(Constants.DARK_SLATE)
        .background(Constants.BACKGROUND_COLOR)
        .cornerRadius(16)
        .onAppear {
            player1TotalFouls = realmManager.getPlayerViolationsCount(playerNumber: 1, isWarnings: false)
            player2TotalFouls = realmManager.getPlayerViolationsCount(playerNumber: 2, isWarnings: false)
            player3TotalFouls = realmManager.getPlayerViolationsCount(playerNumber: 3, isWarnings: false)
            player4TotalFouls = realmManager.getPlayerViolationsCount(playerNumber: 4, isWarnings: false)
            player1TotalWarnings = realmManager.getPlayerViolationsCount(playerNumber: 1, isWarnings: true)
            player2TotalWarnings = realmManager.getPlayerViolationsCount(playerNumber: 2, isWarnings: true)
            player3TotalWarnings = realmManager.getPlayerViolationsCount(playerNumber: 3, isWarnings: true)
            player4TotalWarnings = realmManager.getPlayerViolationsCount(playerNumber: 4, isWarnings: true)
            
            let wPlayer1Display = realmManager.getPlayerViolationsDisplay(playerNumber: 1, isWarnings: true)
            popoverWPlayer1Display = wPlayer1Display.isEmpty ? "None" : wPlayer1Display
            let wPlayer2Display = realmManager.getPlayerViolationsDisplay(playerNumber: 2, isWarnings: true)
            popoverWPlayer2Display = wPlayer2Display.isEmpty ? "None" : wPlayer2Display
            let wPlayer3Display = realmManager.getPlayerViolationsDisplay(playerNumber: 3, isWarnings: true)
            popoverWPlayer3Display = wPlayer3Display.isEmpty ? "None" : wPlayer3Display
            let wPlayer4Display = realmManager.getPlayerViolationsDisplay(playerNumber: 4, isWarnings: true)
            popoverWPlayer4Display = wPlayer4Display.isEmpty ? "None" : wPlayer4Display
            
            let fPlayer1Display = realmManager.getPlayerViolationsDisplay(playerNumber: 1, isWarnings: false)
            popoverTFPlayer1Display = fPlayer1Display.isEmpty ? "None" : fPlayer1Display
            let fPlayer2Display = realmManager.getPlayerViolationsDisplay(playerNumber: 2, isWarnings: false)
            popoverTFPlayer2Display = fPlayer2Display.isEmpty ? "None" : fPlayer2Display
            let fPlayer3Display = realmManager.getPlayerViolationsDisplay(playerNumber: 3, isWarnings: false)
            popoverTFPlayer3Display = fPlayer3Display.isEmpty ? "None" : fPlayer3Display
            let fPlayer4Display = realmManager.getPlayerViolationsDisplay(playerNumber: 4, isWarnings: false)
            popoverTFPlayer4Display = fPlayer4Display.isEmpty ? "None" : fPlayer4Display
        }
    }
    
}

struct ViolationStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ViolationStatusView(match: Match())
    }
}


