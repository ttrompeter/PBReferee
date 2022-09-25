//
//  MedicalTimeOutView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/12/22.
//

import RealmSwift
import SwiftUI

struct MedicalTimeOutView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var match: Match
    @State private var isServingTeamButtonSelected = false
    @State private var isReceivingTeamButtonSelected = false
    @State private var isButtonTapped = false
    @State private var presentReceivingTeamNoTimeOutsAvailableAlert = false
    @State private var presentServingTeamNoTimeOutsAvailableAlert = false
    private let servingTeam = 1
    private let receivingTeam = 2
    private let team1 = 1
    private let team2 = 2
    
    var body: some View {
        
        VStack (spacing: 10) {
            
//            Text("Time Out")
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Constants.DARK_SLATE)
//                .padding(.top, 5)
            
            HStack (alignment: .top) {
                ZStack {
                    Rectangle()
                        .frame(width: CGFloat(620), height: CGFloat(410))
                        .foregroundColor(Constants.CLOUDS)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    VStack (alignment: .leading, spacing: 2) {
                        
                        Group {
                            Text("Medical Timeout Procedure")
                                .font(.title)
                            Text("\u{2022}") + Text(" A Medical Time out has been called")
                            //Text("\u{2022}") + Text(" Move to side of court of team that called the timeout")
                            //Text("\u{2022}") + Text(" The score is  \(match.scoreDisplay)")
                            Text("\u{2022}") + Text("There will be 15 minutes for medical service")
                            Text("\u{2022}") + Text(" Start Stopwatch")
                            //Text("\u{2022}") + Text(" Move to center court")
                            //Text("\u{2022}") + Text(" Record time out in the appropriate box on scoresheet")
                        }
                        Group {
                            Text("\u{2022}") + Text(" At 15 seconds remaining, announce:")
                            Text("\u{2022}") + Text(" Warning: 15 Seconds")
                            Text("\u{2022}") + Text(" Move back to your referee position")
                            Text("\u{2022}") + Text(" Announce:")
                            if match.isTeam1Serving {
                                Text("     Serving team you have ") + Text("\(3 - match.games[match.currentGameArrayIndex].timeOutsTakenTeam1)  timeouts remaining")
                                    .font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                                Text("     Receiving team you have ") + Text("\(3 - match.games[match.currentGameArrayIndex].timeOutsTakenTeam2)  timeouts remaining")
                                    .font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                            } else {
                                Text("     Receiving team you have ") + Text("\(3 - match.games[match.currentGameArrayIndex].timeOutsTakenTeam2)  timeouts remaining")
                                    .font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                                Text("     Serving team you have ") + Text("\(3 - match.games[match.currentGameArrayIndex].timeOutsTakenTeam1)  timeouts remaining")
                                    .font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                            }
                            Text("\u{2022}") + Text(" Check readiness of line judges  (if applicable)")
                            Text("\u{2022}") + Text(" Announce: Time in")
                            Text("\u{2022}") + Text(" Announce score:  ") + Text("\(match.scoreDisplay)")
                                                                                .font(.title3)
                                                                                .foregroundColor(Constants.CRIMSON)
                        }
                    }
                }
            }
            .padding(.top, 10)
            
            VStack {
                HStack (alignment: .center) {
                    
                    StopwatchMinSec()
                    
                    VStack {
                        Spacer()
                        Text("Time Out Charged To")
                        Button {
                            if validateTimeOut(team: servingTeam) {
                                timeOutTaken(teamTakingTimeOut: servingTeam)
                                isServingTeamButtonSelected = true
                                isButtonTapped = true
                            } else {
                                presentServingTeamNoTimeOutsAvailableAlert = true
                            }
                            
                        } label: {
                            Text("Serving Team")
                        }
                        .buttonStyle(TimeoutsButtonStyle())
                        .disabled(isButtonTapped)
                        .alert("Receiving Team has no Time Outs available.", isPresented: $presentServingTeamNoTimeOutsAvailableAlert, actions: {})
                        if match.isTeam1Serving {
                            Text("\(match.namePlayer1Team1) | \(match.namePlayer2Team1)")
                                .font(.body).italic()
                                .foregroundColor(Constants.MINT_LEAF)
                        } else {
                            Text("\(match.namePlayer1Team2) | \(match.namePlayer2Team2)")
                                .font(.body).italic()
                                .foregroundColor(Constants.MINT_LEAF)
                        }
                        
                        Spacer()
                        Button {
                            if validateTimeOut(team: receivingTeam) {
                                timeOutTaken(teamTakingTimeOut: receivingTeam)
                                isReceivingTeamButtonSelected = true
                                isButtonTapped = true
                            } else {
                                presentReceivingTeamNoTimeOutsAvailableAlert = true
                            }
                        } label: {
                            Text("Receiving Team")
                        }
                        .buttonStyle(TimeoutsButtonStyle())
                        .disabled(isButtonTapped)
                        .alert("Receiving Team has no Time Outs available.", isPresented: $presentReceivingTeamNoTimeOutsAvailableAlert, actions: {})
                        if match.isTeam1Serving {
                            Text("\(match.namePlayer1Team2) | \(match.namePlayer2Team2)")
                                .font(.body).italic()
                                .foregroundColor(Constants.MINT_LEAF)
                        } else {
                            Text("\(match.namePlayer1Team1) | \(match.namePlayer2Team1)")
                                .font(.body).italic()
                                .foregroundColor(Constants.MINT_LEAF)
                        }
                       
                        Spacer()
                    }
                    .padding(10)
                    .background(Constants.CLOUDS)
                }
            }
            
            VStack {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 5)
        }
    }
    
    func validateTimeOut(team: Int) -> Bool {
        
        return true
    }
    
    func timeOutTaken (teamTakingTimeOut: Int) {
        
    }
}

struct MedicalTimeOutView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalTimeOutView(match: Match())
    }
}

