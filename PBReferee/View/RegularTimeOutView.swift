//
//  TimeOutView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

struct RegularTimeOutView: View {
    
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
            
            HStack (alignment: .top) {
                ZStack {
                    Rectangle()
                        .frame(width: CGFloat(620), height: CGFloat(410))
                        .foregroundColor(Constants.CLOUDS)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    VStack (alignment: .leading, spacing: 2) {
                        
                        Group {
                            Text("Regular Timeout Procedure")
                                .font(.title)
                            Text("\u{2022}") + Text(" Time out has been called by the [Receiving / Serving] Team")
                            Text("\u{2022}") + Text(" Start Stopwatch")
                            Text("\u{2022}") + Text(" Move to side of court of team that called the timeout")
                            Text("\u{2022}") + Text(" The score is  \(match.scoreDisplay)")
                            Text("\u{2022}") + Text(" Warning: You have one minute")
                            Text("\u{2022}") + Text(" Move to center court")
                            //Text("\u{2022}") + Text(" Record time out in the appropriate box on scoresheet")
                        }
                        Group {
                            Text("\u{2022}") + Text(" At 15 seconds remaining, announce:")
                            Text("\u{2022}") + Text(" Warning: 15 Seconds")
                            Text("\u{2022}") + Text(" Move back to your referee position")
                            Text("\u{2022}") + Text(" Announce:")
                            if match.isTeam1Serving {
                                Text("     Serving team you have ") + Text("\(3 - match.games[match.currentGameArrayIndex].timeOutsTeam1)  timeouts remaining")
                                    .font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                                Text("     Receiving team you have ") + Text("\(3 - match.games[match.currentGameArrayIndex].timeOutsTeam2)  timeouts remaining")
                                    .font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                            } else {
                                Text("     Receiving team you have ") + Text("\(3 - match.games[match.currentGameArrayIndex].timeOutsTeam2)  timeouts remaining")
                                    .font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                                Text("     Serving team you have ") + Text("\(3 - match.games[match.currentGameArrayIndex].timeOutsTeam1)  timeouts remaining")
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
                        Text("Select Team Taking Time Out")
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
        
        if team == servingTeam {
            // Time Out by Serving Team
            if match.isTeam1Serving {
                if match.selectedMatchFormat == 3 {
                    if match.games[match.currentGameArrayIndex].timeOutsTeam1 > 2 {
                        // No timeouts avaiable
                        return false
                    }
                } else {
                    if match.games[match.currentGameArrayIndex].timeOutsTeam1 > 1 {
                        // No timeouts avaiable
                        return false
                    }
                }
            } else {
                
                if match.selectedMatchFormat == 3 {
                    if match.games[match.currentGameArrayIndex].timeOutsTeam2 > 2 {
                        // No timeouts avaiable
                        return false
                    }
                } else {
                    if match.games[match.currentGameArrayIndex].timeOutsTeam2 > 1 {
                        // No timeouts avaiable
                        return false
                    }
                }
            }
        } else {  // team == 2 == receiving team
            // Time Out by Receiving Team
            if match.isTeam1Serving {
                if match.selectedMatchFormat == 3 {
                    if match.games[match.currentGameArrayIndex].timeOutsTeam2 > 2 {
                        // No timeouts avaiable
                        return false
                    }
                } else {
                    if match.games[match.currentGameArrayIndex].timeOutsTeam2 > 1 {
                        // No timeouts avaiable
                        return false
                    }
                }
            } else {
                if match.selectedMatchFormat == 3 {
                    if match.games[match.currentGameArrayIndex].timeOutsTeam1 > 2 {
                        // No timeouts avaiable
                        return false
                    }
                } else {
                    if match.games[match.currentGameArrayIndex].timeOutsTeam1 > 1 {
                        // No timeouts avaiable
                        return false
                    }
                }
            }
        }
        return true
    }
    
    
    func timeOutTaken (teamTakingTimeOut: Int) {
        
        if teamTakingTimeOut == servingTeam {
            // Time Out by Serving Team
            if match.isTeam1Serving {
                $match.games[match.currentGameArrayIndex].timeOutsTeam1.wrappedValue += 1
                setTimeoutImage(team: team1)
                $scoresheetManager.isTimeOutTaken.wrappedValue = true
                $match.teamTakingTimeout.wrappedValue = 1
            } else {
                $match.games[match.currentGameArrayIndex].timeOutsTeam2.wrappedValue += 1
                setTimeoutImage(team: team2)
                $scoresheetManager.isTimeOutTaken.wrappedValue = true
                $match.teamTakingTimeout.wrappedValue = 2
            }
            
        } else {
            // Time Out by Receiving Team
            if match.isTeam1Serving {
                $match.games[match.currentGameArrayIndex].timeOutsTeam2.wrappedValue += 1
                setTimeoutImage(team: team2)
                $scoresheetManager.isTimeOutTaken.wrappedValue = true
                $match.teamTakingTimeout.wrappedValue = 2
            } else {
                $match.games[match.currentGameArrayIndex].timeOutsTeam1.wrappedValue += 1
                setTimeoutImage(team: team1)
                $scoresheetManager.isTimeOutTaken.wrappedValue = true
                $match.teamTakingTimeout.wrappedValue = 1
            }
        }
    }
    
    func setTimeoutImage(team: Int) {
        
        if team == team1 {
            switch match.games[match.currentGameArrayIndex].timeOutsTeam1 {
            case 1:
                if match.currentGameNumber == 1 {
                    $match.images[0].timeOut1Game1ImageTm1.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 2 {
                    $match.images[0].timeOut1Game2ImageTm1.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 3 {
                    $match.images[0].timeOut1Game3ImageTm1.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 4 {
                    $match.images[0].timeOut1Game4ImageTm1.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 5 {
                    $match.images[0].timeOut1Game5ImageTm1.wrappedValue = "boxleftfwdslash"
                }
            case 2:
                if match.selectedMatchFormat == 3 {
                    if match.currentGameNumber == 1 {
                        $match.images[0].timeOut2Game1ImageTm1.wrappedValue = "boxleftfwdslash"
                    } else if match.currentGameNumber == 2 {
                        $match.images[0].timeOut2Game2ImageTm1.wrappedValue = "boxleftfwdslash"
                    } else if match.currentGameNumber == 3 {
                        $match.images[0].timeOut2Game3ImageTm1.wrappedValue = "boxleftfwdslash"
                    } else if match.currentGameNumber == 4 {
                        $match.images[0].timeOut2Game4ImageTm1.wrappedValue = "boxleftfwdslash"
                    } else if match.currentGameNumber == 5 {
                        $match.images[0].timeOut2Game5ImageTm1.wrappedValue = "boxleftfwdslash"
                    }
                } else {
                    if match.currentGameNumber == 1 {
                        $match.images[0].timeOut2Game1ImageTm1.wrappedValue = "boxrightendfwdslash"
                    } else if match.currentGameNumber == 2 {
                        $match.images[0].timeOut2Game2ImageTm1.wrappedValue = "boxrightendfwdslash"
                    } else if match.currentGameNumber == 3 {
                        $match.images[0].timeOut2Game3ImageTm1.wrappedValue = "boxrightendfwdslash"
                    } else if match.currentGameNumber == 4 {
                        $match.images[0].timeOut2Game4ImageTm1.wrappedValue = "boxrightendfwdslash"
                    } else if match.currentGameNumber == 5 {
                        $match.images[0].timeOut2Game5ImageTm1.wrappedValue = "boxfwdslash"
                    }
                }
                
            case 3:
                if match.currentGameNumber == 1 {
                    $match.images[0].timeOut3Game1ImageTm1.wrappedValue = "boxrightendfwdslash"
                } else if match.currentGameNumber == 2 {
                    $match.images[0].timeOut3Game2ImageTm1.wrappedValue = "boxrightendfwdslash"
                } else if match.currentGameNumber == 3 {
                    $match.images[0].timeOut3Game3ImageTm1.wrappedValue = "boxrightendfwdslash"
                } else if match.currentGameNumber == 4 {
                    $match.images[0].timeOut3Game4ImageTm1.wrappedValue = "boxrightendfwdslash"
                } else if match.currentGameNumber == 5 {
                    $match.images[0].timeOut3Game5ImageTm1.wrappedValue = "boxfwdslash"
                }
            default:
                print("Error setting image in switch statement of setTimeoutImage()")
            }
            
        } else if team == team2 {
            print("In if receiving team setTimeoutImage()\n")
            switch match.games[match.currentGameArrayIndex].timeOutsTeam2 {
            case 1:
                if match.currentGameNumber == 1 {
                    $match.images[0].timeOut1Game1ImageTm2.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 2 {
                    $match.images[0].timeOut1Game2ImageTm2.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 3 {
                    $match.images[0].timeOut1Game3ImageTm2.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 4 {
                    $match.images[0].timeOut1Game4ImageTm2.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 5 {
                    $match.images[0].timeOut1Game5ImageTm2.wrappedValue = "boxleftfwdslash"
                }
            case 2:
                if match.selectedMatchFormat == 3 {
                    if match.currentGameNumber == 1 {
                        $match.images[0].timeOut2Game1ImageTm2.wrappedValue = "boxleftfwdslash"
                    } else if match.currentGameNumber == 2 {
                        $match.images[0].timeOut2Game2ImageTm2.wrappedValue = "boxleftfwdslash"
                    } else if match.currentGameNumber == 3 {
                        $match.images[0].timeOut2Game3ImageTm2.wrappedValue = "boxleftfwdslash"
                    } else if match.currentGameNumber == 4 {
                        $match.images[0].timeOut2Game4ImageTm2.wrappedValue = "boxleftfwdslash"
                    } else if match.currentGameNumber == 5 {
                        $match.images[0].timeOut2Game5ImageTm2.wrappedValue = "boxleftfwdslash"
                    }
                } else {
                    if match.currentGameNumber == 1 {
                        $match.images[0].timeOut2Game1ImageTm2.wrappedValue = "boxrightendfwdslash"
                    } else if match.currentGameNumber == 2 {
                        $match.images[0].timeOut2Game2ImageTm2.wrappedValue = "boxrightendfwdslash"
                    } else if match.currentGameNumber == 3 {
                        $match.images[0].timeOut2Game3ImageTm2.wrappedValue = "boxrightendfwdslash"
                    } else if match.currentGameNumber == 4 {
                        $match.images[0].timeOut2Game4ImageTm2.wrappedValue = "boxrightendfwdslash"
                    } else if match.currentGameNumber == 5 {
                        $match.images[0].timeOut2Game5ImageTm2.wrappedValue = "boxfwdslash"
                    }
                }
                
            case 3:
                if match.currentGameNumber == 1 {
                    $match.images[0].timeOut3Game1ImageTm2.wrappedValue = "boxrightendfwdslash"
                } else if match.currentGameNumber == 2 {
                    $match.images[0].timeOut3Game2ImageTm2.wrappedValue = "boxrightendfwdslash"
                } else if match.currentGameNumber == 3 {
                    $match.images[0].timeOut3Game3ImageTm2.wrappedValue = "boxrightendfwdslash"
                } else if match.currentGameNumber == 4 {
                    $match.images[0].timeOut3Game4ImageTm2.wrappedValue = "boxrightendfwdslash"
                } else if match.currentGameNumber == 5 {
                    $match.images[0].timeOut3Game5ImageTm2.wrappedValue = "boxfwdslash"
                }
            default:
                print("Error setting image in switch statement of setTimeoutImage()")
            }
        }
        
        
    }
    
}

//struct RegularTimeOutView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegularTimeOutView()
//    }
//}


