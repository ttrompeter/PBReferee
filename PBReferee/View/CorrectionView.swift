//
//  EditView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

struct CorrectionView: View {
    
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var match: Match
    
    @State private var correctionText = "Tap 'Make Correction' Button To Make The Correction"
    @State private var isCorrected = false
    @State private var isCorrectPointScored = false
    @State private var isCorrectSecondeServer = false
    @State private var isCorrectSideOut = false
    @State private var isCorrectTimeout = false
    @State private var isCorrectViolation = false
    @State private var selectedActionToCorrect = 0
    
    var body: some View {
        
        VStack {
            
            Text("Correction")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Constants.DARK_SLATE)
                .padding(30)
            
            ZStack {
                Rectangle()
                    .frame(width: CGFloat(660), height: CGFloat(410))
                    .foregroundColor(Constants.CLOUDS)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                VStack {
                    
                    Text("Action To Correct")
                        .font(.title)
                    
                    HStack {
                        Text("Select Action To Correct: ")
                            .font(.title3)
                        
                        Picker(selection: $selectedActionToCorrect,
                               label: Text(" "),
                               content:  {
                            Text("Select Action").tag(0)
                            Text("Undo Point Scored").tag(1)
                            Text("Undo 2nd Server").tag(2)
                            Text("Undo Side Out").tag(3)
                            Text("Undo Timeout").tag(4)
                            Text("Undo Violation").tag(5)
                        })
                        .pickerStyle(MenuPickerStyle())
                        .fixedSize()
                    }
                    
                    Text("\(correctionText)")
                        .padding(.top, 30)
                        .font(.headline)
                        .foregroundColor(Constants.MINT_LEAF)
                    
                    Button {
                        
                        if isCorrected {
                            dismiss()
                        } else {
                            /*
                             These values are set in action code elsewhere:
                             scoresheetManager.lastActionGameNumber
                             scoresheetManager.lastActionIsSecondServer
                             scoresheetManager.lastActionPlayerNumber
                             scoresheetManager.lastActionScore
                             */

                            if selectedActionToCorrect == 1 {
                                correctPointScored()
                            }
                            if selectedActionToCorrect == 2 {
                                correctSecondServer()
                            }
                            if selectedActionToCorrect == 3 {
                                correctSideOut()
                            }
                            if selectedActionToCorrect == 4 {
                                correctTimeout()
                            }
                            if selectedActionToCorrect == 5 {
                                correctViolation()
                            }
                        }
                    } label: {
                        if isCorrected {
                            Text("Close")
                            
                        } else {
                            Text("Make Correction")
                        }
                    }
                    .padding(.top, 30)
                    .buttonStyle(WideButtonStyle())
                    .disabled(selectedActionToCorrect == 0)
                    
                }  // End VStack
            }  // End ZStack
            
            Spacer()
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 20)
        } // Top VStack
        .navigationBarBackButtonHidden(true)
    }
    
    func correctPointScored() {
        print("Starting correctPointScored in CorrectionView")
        
        var pointNumber = 0
        var teamNumber = 0
        
        // TODO: - Delete these print statement in production
        print("pointNumber JUST TO STOP WARNING - DELETE LATER: \(pointNumber)")
        print("teamNumber JUST TO STOP WARNING - DELETE LATER: \(teamNumber)")
        
        // Subtract point from player who last scored
        switch scoresheetManager.lastActionPlayerNumber {
        case 1:
            pointNumber = match.games[match.currentGameArrayIndex].player1Points
            $match.games[match.currentGameArrayIndex].player1Points.wrappedValue -= 1
            teamNumber = 1
        case 2:
            pointNumber = match.games[match.currentGameArrayIndex].player2Points
            $match.games[match.currentGameArrayIndex].player2Points.wrappedValue -= 1
            teamNumber = 1
        case 3:
            pointNumber = match.games[match.currentGameArrayIndex].player3Points
            $match.games[match.currentGameArrayIndex].player3Points.wrappedValue -= 1
            teamNumber = 2
        case 4:
            pointNumber = match.games[match.currentGameArrayIndex].player4Points
            $match.games[match.currentGameArrayIndex].player4Points.wrappedValue -= 1
            teamNumber = 2
        default:
            print("Error correcting Point Scored in CorrectionView")
        }
        
        // TODO: - Figure out how to set the image back
        // Correct image display
        // $match.images[0].point2Game2ImageTm1.wrappedValue = Constants.BOX_BOTTOM_LEFT
        // BOX_LEFT
        // BOX_LEFT_ONLY
        // BOX_RIGHT_ONLY_END
        // BOX
        // BOX_RIGHT_END
        // BOX_BOTTOM_LEFT
        
        
        // $match.images[0].point + pointNumber + Game + scoresheetManager.lastActionGameNumber + ImageTm + teamNumber +.wrappedValue = Constants.BOX_LEFT
        
        
//        scoresheetManager.updateScore(match: match)
        
        let tm1Score = (match.games[match.currentGameArrayIndex].player1Points) + (match.games[match.currentGameArrayIndex].player2Points)
        let tm2Score = (match.games[match.currentGameArrayIndex].player3Points) + (match.games[match.currentGameArrayIndex].player4Points)
        let server = match.isSecondServer == true ? "2" : "1"
        if match.isTeam1Serving {
            $match.scoreDisplay.wrappedValue = "\(tm1Score) - \(tm2Score) - \(server)"
        } else {
            $match.scoreDisplay.wrappedValue = "\(tm2Score) - \(tm1Score) - \(server)"
        }
        
        correctionText = "The Point Scored Was Corrected"
        isCorrected = true
    }
    
    func correctSecondServer() {
        
        print("Starting correctSecondServer in CorrectionView")
        // Set the servingPlayerNumber back to the previous server
        $match.servingPlayerNumber.wrappedValue = scoresheetManager.lastActionPlayerNumber
        // Change isSecondServer back to false
        $match.isSecondServer.wrappedValue = false
        // Change the whoIsServerText back to '1stServer'
        $match.whoIsServingText.wrappedValue = "1st Server"
        correctionText = "The Change To Second Server Was Corrected"
        isCorrected = true
    }
    
    func correctSideOut() {
        print("Starting correctSideOut in CorrectionView")
        
        // Set the sideOUtsTeam value back to prior value
        // Subtract a sideout from team who was called for side out
        switch scoresheetManager.lastActionPlayerNumber {
        case 1, 2:
            //pointNumber = match.games[match.currentGameArrayIndex].player1Points
            $match.games[match.currentGameArrayIndex].sideOutsTeam1.wrappedValue -= 1
            //teamNumber = 1
//        case 2:
//            //pointNumber = match.games[match.currentGameArrayIndex].player2Points
//            $match.games[match.currentGameArrayIndex].sideOutsTeam1.wrappedValue -= 1
//            //teamNumber = 1
        case 3, 4:
            //pointNumber = match.games[match.currentGameArrayIndex].player3Points
            $match.games[match.currentGameArrayIndex].sideOutsTeam2.wrappedValue -= 1
            //teamNumber = 2
//        case 4:
//            //pointNumber = match.games[match.currentGameArrayIndex].player4Points
//            $match.games[match.currentGameArrayIndex].sideOutsTeam2.wrappedValue -= 1
            //teamNumber = 2
        default:
            print("Error correcting Point Scored in CorrectionView")
        }
        
        // Set the servingPlayerNumber back to the previous server
        $match.servingPlayerNumber.wrappedValue = scoresheetManager.lastActionPlayerNumber
        // Set the isSecondServer back to the previous state
        $match.isSecondServer.wrappedValue = scoresheetManager.lastActionIsSecondServer
        // Set the isTeam1Serving back to previous state
        $match.isTeam1Serving.wrappedValue.toggle()
        // Set the isServingLeftSide back to previous state
        $match.isServingLeftSide.wrappedValue.toggle()
        
        correctionText = "The Side Out Was Corrected"
        isCorrected = true
        
        // TODO: - Figure out how to set the image back
        // Set the image back to without the sideout line
        // $match.images[0].isSideoutPoint0Game1Team1.wrappedValue = true
        
        //        From SideoutExtension
        //        // Set server to the next server
        //        setServingPlayerNumber()
        //        $match.isSecondServer.wrappedValue.toggle()
        //        $match.whoIsServingText.wrappedValue = "1st Server"
        //
        //        // Team service game is over so change values for isTeam1Serving and isServingLeftSide
        //        $match.isTeam1Serving.wrappedValue.toggle()
        //        $match.isServingLeftSide.wrappedValue.toggle()
    }
    
    func correctTimeout() {
        print("Starting correctTimeout in CorrectionView")
        
        // Subtract a timeout from team who was asigned a timeout & set the teamTakingTimeout back to default value of 0
        switch scoresheetManager.lastActionPlayerNumber {
        case 1, 2:
            $match.games[match.currentGameArrayIndex].timeOutsTeam1.wrappedValue -= 1
            $match.teamTakingTimeout.wrappedValue = 0
        case 3, 4:
            $match.games[match.currentGameArrayIndex].timeOutsTeam2.wrappedValue -= 1
            $match.teamTakingTimeout.wrappedValue = 0
        default:
            print("Error correcting Point Scored in CorrectionView")
        }
        
        // Set the isTimeOutTaken value back to previous value
        $scoresheetManager.isTimeOutTaken.wrappedValue = false
        
        // TODO: - Figure out how to set the image back
        // Set the TimeoutImage back to previous value
        //$match.images[0].timeOut1Game1ImageTm1.wrappedValue = Constants.BOX_LEFT
        
        
        
//        Actions is RegularTimeout
//        $match.games[match.currentGameArrayIndex].timeOutsTeam1.wrappedValue += 1
//        setTimeoutImage(team: team1)
//        $scoresheetManager.isTimeOutTaken.wrappedValue = true
//        $match.teamTakingTimeout.wrappedValue = 1
        
        
        correctionText = "The Timeout Was Corrected"
        isCorrected = true
    }
    
    func correctViolation() {
        print("Starting correctViolation in CorrectionView")
        
        // Delete the violation that was saved
        // realmManager.saveViolation(newViolation)
        
        // Change the display showing the violation image
        // $match.isShowViolation1Tm1.wrappedValue = true
        
        correctionText = "The Violation Was Corrected"
        isCorrected = true
    }
}



struct CorrectionView_Previews: PreviewProvider {
    static var previews: some View {
        CorrectionView(match: Match())
    }
}

