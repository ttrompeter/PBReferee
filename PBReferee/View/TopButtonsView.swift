//
//  TopButtonsView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//
import RealmSwift
import SwiftUI

struct TopButtonsView: View {
    
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var match: Match
    
    @State private var presentCoinTossAlert = false
    @State private var showingCorrection = false
    @State private var showingMatchSetup = false
    @State private var showingPreMatchBriefing = false
    @State private var showingTimeOut = false
    @State private var showingViolation = false
    
    let randomCoinToss = Int.random(in: 1...2)
    
    var body: some View {
        
        VStack (spacing: 20) {
            Button {
                showingTimeOut.toggle()
            } label: {
                Text("Timeout")
            }
            .buttonStyle(FunctionsButtonStyle())
            .sheet(isPresented: $showingTimeOut) { TimeOutsView(match: match) }
            
            Button {
                showingPreMatchBriefing.toggle()
            } label: {
                Text("Briefing")
            }
            .buttonStyle(FunctionsButtonStyle())
            .sheet(isPresented: $showingPreMatchBriefing) { PreMatchBriefingView() }
            
            Button {
                showingMatchSetup.toggle()
            } label: {
                if match.isMatchSetupCompleted {
                    Text("Edit Match")
                } else {
                    Text("Match Setup")
                }
            }
            .buttonStyle(FunctionsButtonStyle())
            .disabled(match.isCompleted)
            .sheet(isPresented: $showingMatchSetup) { MatchSetupView(match:match) }
            
            Button {
                showingCorrection.toggle()
            } label: {
                Text("Correction")
            }
            .buttonStyle(FunctionsButtonStyle())
            .disabled(!match.isMatchStarted || match.isCompleted)
            .sheet(isPresented: $showingCorrection) { CorrectionView(match: match) }
    
            if !scoresheetManager.isMatchStartingServerSet {
                Button {
                    presentCoinTossAlert.toggle()
                } label: {
                    Text("Coin Toss")
                }
                .buttonStyle(FunctionsButtonStyleGreen())
                .disabled(!match.isMatchSetupCompleted)
                .alert("\(randomCoinToss)", isPresented: $presentCoinTossAlert) {
                    Button("Done", role: .cancel) {
                    }
                }
            } else {
                Button {
                    showingViolation.toggle()
                } label: {
                    Text("Violation")
                }
                .buttonStyle(FunctionsButtonStyle())
                .sheet(isPresented: $showingViolation) { ViolationView(match: match) }
            }
            
        }
        .padding(10)
        .background(Constants.CLOUDS)
    }

}

struct TopButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonsView(match: Match())
    }
}

