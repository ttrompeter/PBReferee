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
    @State private var isServingTeamButtonTapped = false
    @State private var isReceivingTeamButtonTapped = false
    @State private var isTimeOutTaken = false
    @State private var teamTakingTimeOut = 0
    //@State private var presentReceivingTeamNoTimeOutsAvailableAlert = false
    //@State private var presentServingTeamNoTimeOutsAvailableAlert = false
    @State private var presentNoTimeOutsAvailableAlert = false
    @State private var servingTeam = 1
    @State private var receivingTeam = 2
    
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
                                Text("     Serving team you have ") + Text("\(match.numberOfTimeoutsPerGame - match.games[match.currentGameArrayIndex].timeOutsTakenTeam1)  timeouts remaining")
                                //.font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                                Text("     Receiving team you have ") + Text("\(match.numberOfTimeoutsPerGame - match.games[match.currentGameArrayIndex].timeOutsTakenTeam2)  timeouts remaining")
                                //.font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                            } else {
                                Text("     Receiving team you have ") + Text("\(match.numberOfTimeoutsPerGame - match.games[match.currentGameArrayIndex].timeOutsTakenTeam2)  timeouts remaining")
                                //.font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                                Text("     Serving team you have ") + Text("\(match.numberOfTimeoutsPerGame - match.games[match.currentGameArrayIndex].timeOutsTakenTeam1)  timeouts remaining")
                                //.font(.title3)
                                    .foregroundColor(Constants.CRIMSON)
                            }
                            Text("\u{2022}") + Text(" Check readiness of line judges  (if applicable)")
                            Text("\u{2022}") + Text(" Announce: Time in")
                            Text("\u{2022}") + Text(" Announce score:  ") + Text("\(match.scoreDisplay)")
                            //.font(.title3)
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
                            if validateTimeOutAvailable() {
                                if match.isTeam1Serving {
                                    //$servingTeam.wrappedValue = 1
                                    //$receivingTeam.wrappedValue = 2
                                    $teamTakingTimeOut.wrappedValue = 1
                                } else {
                                    //$servingTeam.wrappedValue = 2
                                    //$receivingTeam.wrappedValue = 1
                                    $teamTakingTimeOut.wrappedValue = 1
                                }
                                timeOutTaken(timeOutTakenByTeam: teamTakingTimeOut)
                                isServingTeamButtonTapped = true
                                isTimeOutTaken = true
                            } else {
                                //presentServingTeamNoTimeOutsAvailableAlert = true
                                presentNoTimeOutsAvailableAlert = true
                            }
                            
                        } label: {
                            Text("Serving Team")
                        }
                        .buttonStyle(TimeoutsButtonStyle())
                        .disabled(isTimeOutTaken)
                        //.alert("The Team has no Time Outs available.", isPresented: $presentServingTeamNoTimeOutsAvailableAlert, actions: {})
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
                            if validateTimeOutAvailable() {
                                if match.isTeam1Serving {
                                    //$servingTeam.wrappedValue = 1
                                    //$receivingTeam.wrappedValue = 2
                                    $teamTakingTimeOut.wrappedValue = 2
                                } else {
                                    //$servingTeam.wrappedValue = 2
                                    //$receivingTeam.wrappedValue = 1
                                    $teamTakingTimeOut.wrappedValue = 1
                                }
                                timeOutTaken(timeOutTakenByTeam: teamTakingTimeOut)
                                isReceivingTeamButtonTapped = true
                                isTimeOutTaken = true
                            } else {
                                //presentReceivingTeamNoTimeOutsAvailableAlert = true
                                presentNoTimeOutsAvailableAlert = true
                            }
                        } label: {
                            Text("Receiving Team")
                        }
                        .buttonStyle(TimeoutsButtonStyle())
                        .disabled(isTimeOutTaken)
                        //.alert("Receiving Team has no Time Outs available.", isPresented: $presentReceivingTeamNoTimeOutsAvailableAlert, actions: {})
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
                    .alert("The Team has No Time Outs Available.", isPresented: $presentNoTimeOutsAvailableAlert, actions: {})
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
        .onAppear {
            

        }
    }
    
    
    func validateTimeOutAvailable() -> Bool {
        
        if match.selectedMatchFormat == 3 {
            if match.games[match.currentGameArrayIndex].timeOutsTakenTeam1 > 2 || match.games[match.currentGameArrayIndex].timeOutsTakenTeam2 > 2 {
                return false     // No timeouts avaiable
            }
        } else {
            if match.games[match.currentGameArrayIndex].timeOutsTakenTeam1 > 1 ||  match.games[match.currentGameArrayIndex].timeOutsTakenTeam2 > 1 {
                return false     // No timeouts avaiable
            }
        }
        return true

        //        if team == servingTeam {
        //            // Time Out by Serving Team
        //            if match.isTeam1Serving {
        //                //return (match.selectedMatchFormat == 3 ? false : true)
        //                if match.selectedMatchFormat == 3 {
        //                    if match.games[match.currentGameArrayIndex].timeOutsTeam1 > 2 || match.games[match.currentGameArrayIndex].timeOutsTeam2 > 2 {
        //                        // No timeouts avaiable
        //                        return false
        //                    }
        //                } else {
        //                    if match.games[match.currentGameArrayIndex].timeOutsTeam1 > 1 ||  match.games[match.currentGameArrayIndex].timeOutsTeam2 > 1 {
        //                        // No timeouts avaiable
        //                        return false
        //                    }
        //                }
        //            } else {
        //
        //                if match.selectedMatchFormat == 3 {
        //                    if match.games[match.currentGameArrayIndex].timeOutsTeam2 > 2 {
        //                        // No timeouts avaiable
        //                        return false
        //                    }
        //                } else {
        //                    if match.games[match.currentGameArrayIndex].timeOutsTeam2 > 1 {
        //                        // No timeouts avaiable
        //                        return false
        //                    }
        //                }
        //            }
        //        } else {  // team == 2 == receiving team
        //            // Time Out by Receiving Team
        //            if match.isTeam1Serving {
        //                if match.selectedMatchFormat == 3 {
        //                    if match.games[match.currentGameArrayIndex].timeOutsTeam2 > 2 {
        //                        // No timeouts avaiable
        //                        return false
        //                    }
        //                } else {
        //                    if match.games[match.currentGameArrayIndex].timeOutsTeam2 > 1 {
        //                        // No timeouts avaiable
        //                        return false
        //                    }
        //                }
        //            } else {
        //                if match.selectedMatchFormat == 3 {
        //                    if match.games[match.currentGameArrayIndex].timeOutsTeam1 > 2 {
        //                        // No timeouts avaiable
        //                        return false
        //                    }
        //                } else {
        //                    if match.games[match.currentGameArrayIndex].timeOutsTeam1 > 1 {
        //                        // No timeouts avaiable
        //                        return false
        //                    }
        //                }
        //            }
        //        }
        
    }
    
    
    func timeOutTaken (timeOutTakenByTeam: Int) {
        
        if timeOutTakenByTeam == 1 {
            $match.games[match.currentGameArrayIndex].timeOutsTakenTeam1.wrappedValue += 1
            setTimeoutImage(team: 1)
            $scoresheetManager.isTimeOutTaken.wrappedValue = true
            $match.teamTakingTimeout.wrappedValue = 1
        } else {
            $match.games[match.currentGameArrayIndex].timeOutsTakenTeam2.wrappedValue += 1
            setTimeoutImage(team: 2)
            $scoresheetManager.isTimeOutTaken.wrappedValue = true
            $match.teamTakingTimeout.wrappedValue = 2
        }
        
//        if teamTakingTimeOut == servingTeam {
//            // Time Out by Serving Team
//            if match.isTeam1Serving {
//                $match.games[match.currentGameArrayIndex].timeOutsTeam1.wrappedValue += 1
//                setTimeoutImage(team: 1)
//                $scoresheetManager.isTimeOutTaken.wrappedValue = true
//                $match.teamTakingTimeout.wrappedValue = 1
//            } else {
//                $match.games[match.currentGameArrayIndex].timeOutsTeam2.wrappedValue += 1
//                setTimeoutImage(team: 2)
//                $scoresheetManager.isTimeOutTaken.wrappedValue = true
//                $match.teamTakingTimeout.wrappedValue = 2
//            }
//
//        } else {
//            // Time Out by Receiving Team
//            if match.isTeam1Serving {
//                $match.games[match.currentGameArrayIndex].timeOutsTeam2.wrappedValue += 1
//                setTimeoutImage(team: 2)
//                $scoresheetManager.isTimeOutTaken.wrappedValue = true
//                $match.teamTakingTimeout.wrappedValue = 2
//            } else {
//                $match.games[match.currentGameArrayIndex].timeOutsTeam1.wrappedValue += 1
//                setTimeoutImage(team: 1)
//                $scoresheetManager.isTimeOutTaken.wrappedValue = true
//                $match.teamTakingTimeout.wrappedValue = 1
//            }
//        }
    }
    
    func setTimeoutImage(team: Int) {
        
        /*
         Team 1                                     Team 2
         Timeout 1 Game 1  Index value 0            Timeout 1 Game 1  Index value 15
         Timeout 2 Game 1  Index value 1            Timeout 2 Game 1  Index value 16
         Timeout 3 Game 1  Index value 2            Timeout 3 Game 1  Index value 17
         
         Timeout 1 Game 2  Index value 3            Timeout 1 Game 2  Index value 18
         Timeout 2 Game 2  Index value 4            Timeout 2 Game 2  Index value 19
         Timeout 3 Game 3  Index value 5            Timeout 3 Game 3  Index value 20
         
         Timeout 1 Game 3  Index value 6            Timeout 1 Game 3  Index value 21
         Timeout 2 Game 3  Index value 7            Timeout 2 Game 3  Index value 22
         Timeout 3 Game 3  Index value 8            Timeout 3 Game 3  Index value 23
         
         Timeout 1 Game 4  Index value 9            Timeout 1 Game 4  Index value 24
         Timeout 2 Game 4  Index value 10           Timeout 2 Game 4  Index value 25
         Timeout 3 Game 4  Index value 11           Timeout 3 Game 4  Index value 26
         
         Timeout 1 Game 5  Index value 12           Timeout 1 Game 5  Index value 27
         Timeout 2 Game 5  Index value 13           Timeout 2 Game 5  Index value 28
         Timeout 3 Game 5  Index value 14           Timeout 3 Game 5  Index value 29
         
         Timeout 1 Game 3A  Index value 30          Timeout 1 Game 3A  Index value 33
         Timeout 2 Game 3A  Index value 31          Timeout 1 Game 3A  Index value 34
         Timeout 3 Game 3A  Index value 32          Timeout 1 Game 3A  Index value 35
            
         */
        
        if match.currentGameNumber == 1 {
            // Game 1
            if teamTakingTimeOut == 1 {
                if match.games[0].timeOutsTakenTeam1 == 1 {
                    $match.timeouts[0].boxImageName.wrappedValue = "boxleftfwdslash"
                } else if match.games[0].timeOutsTakenTeam1 == 2 {
                    if match.selectedMatchFormat == 1 {
                        $match.timeouts[1].boxImageName.wrappedValue = "boxrightendfwdslash"
                    } else if match.selectedMatchFormat == 2 {
                        $match.timeouts[1].boxImageName.wrappedValue = "boxrightendfwdslash"
                    } else if match.selectedMatchFormat == 3 {
                        $match.timeouts[1].boxImageName.wrappedValue = "boxleftfwdslash"
                    }
                } else if match.games[0].timeOutsTakenTeam1 == 3 {
                    $match.timeouts[2].boxImageName.wrappedValue = "boxfwdslash"
                }
            } else {
                if match.games[0].timeOutsTakenTeam2 == 1 {
                    $match.timeouts[15].boxImageName.wrappedValue = "boxleftfwdslash"
                } else if match.games[0].timeOutsTakenTeam2 == 2 {
                    if match.selectedMatchFormat == 1 {
                        $match.timeouts[16].boxImageName.wrappedValue = "boxrightendfwdslash"
                    } else if match.selectedMatchFormat == 2 {
                        $match.timeouts[16].boxImageName.wrappedValue = "boxrightendfwdslash"
                    } else if match.selectedMatchFormat == 3 {
                        $match.timeouts[16].boxImageName.wrappedValue = "boxleftfwdslash"
                    }
                } else if match.games[0].timeOutsTakenTeam2 == 3 {
                    $match.timeouts[17].boxImageName.wrappedValue = "boxfwdslash"
                }
            }
        }
        
        
 /*
        if team == 1 {
            switch match.games[match.currentGameArrayIndex].timeOutsTakenTeam1 {
            case 0:
                if match.currentGameNumber == 1 {
                    $match.timeouts[0].boxImageName.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 2 {
                    $match.timeouts[0].boxImageName.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 3 {
                    $match.timeouts[0].boxImageName.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 4 {
                    $match.timeouts[0].boxImageName.wrappedValue = "boxleftfwdslash"
                } else if match.currentGameNumber == 5 {
                    $match.timeouts[0].boxImageName.wrappedValue = "boxleftfwdslash"
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
            
        } else if team == 2 {
            print("In if receiving team setTimeoutImage()\n")
            switch match.games[match.currentGameArrayIndex].timeOutsTakenTeam2 {
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
  */
        
    }
    
}

//struct RegularTimeOutView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegularTimeOutView()
//    }
//}


