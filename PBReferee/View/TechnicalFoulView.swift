//
//  TechnicalFoul.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/21/22.
//

import RealmSwift
import SwiftUI

struct TechnicalFoulView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @EnvironmentObject var sheetManager: SheetManager
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var match: Match
    
    @State private var isForfeitGame = false
    @State private var isForfeitMatch = false
    @State private var isFoulAssessed = false
    @State private var isPointToOpposingTeam = true
    @State private var selectedFoul = 0
    @State private var selectedFoulingPlayer = 0
    @State private var foulDescription = ""
    @FocusState private var foulDescriptionInFocus: foulDescriptionFocusable?
    
    //    init() {
    //        UITextView.appearance().backgroundColor = .clear
    //    }
    
    
    enum foulDescriptionFocusable: Hashable {
        case descriptionText
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Technical Foul")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Constants.DARK_SLATE)
                Image("redcard128")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipped()
            }
            .padding(.vertical, 10)
            
            VStack {
                VStack {
                    Text("Issue A Technical Foul")
                        .font(.title)
                        .padding(.top, 10)
                    VStack (alignment: .leading) {
                        
                        HStack {
                            Text("Player: ")
                            Text(" ")
                            Picker(selection: $selectedFoulingPlayer,
                                   label: Text(" "),
                                   content:  {
                                Text("Select Player").tag(0)
                                Text(match.namePlayer1Team1).tag(1)
                                Text(match.namePlayer2Team1).tag(2)
                                Text(match.namePlayer1Team2).tag(3)
                                Text(match.namePlayer2Team2).tag(4)
                            })
                            .pickerStyle(MenuPickerStyle())
                            .fixedSize()
                            .onChange(of: selectedFoulingPlayer) { tag in
                                if isSecondTechnicalFoul(playerNumber: selectedFoulingPlayer) {
                                    // Automatic forfeiture of match due to 2 technical fouls
                                    forfeitMatch()
                                }
                            }
                        }
                        
                        HStack {
                            Text("Foul: ")
                            Text("      ")
                            Picker(selection: $selectedFoul,
                                   label: Text(" "),
                                   content:  {
                                Text("Select Foul").tag(0)
                                Group {
                                    Text("Breaking the Ball").tag(1)
                                    Text("Cursing").tag(2)
                                    Text("Excessive Appeals").tag(3)
                                    Text("Excessive Arguing").tag(4)
                                    Text("Excessive Questioning").tag(5)
                                    Text("Striking the Ball").tag(6)
                                    Text("Too Much Time").tag(7)
                                    Text("Threats").tag(8)
                                    Text("Throwing Paddle").tag(9)
                                    Text("Other Behavior").tag(10)
                                }
                            })
                            .pickerStyle(MenuPickerStyle())
                            .fixedSize()
                        }
                        
                        HStack (alignment: .top) {
                            Text("Foul Description: ")
                            TextField("Description", text: $foulDescription)
                                .focused($foulDescriptionInFocus, equals: .descriptionText)
                                .frame(width: 260)
                                .foregroundColor(.secondary)
                                .background(Constants.CLOUDS)
                                .padding(.horizontal)
                        }
                        
                        HStack {
                            Toggle(isOn: $isForfeitGame) {
                                Text("Forfeit Game")
                            }
                            .frame(width: 300)
                            
                            if isForfeitGame {
                                Text("Game Will Be Forfeited!")
                                    .font(.callout)
                                    .padding(.leading, 20)
                                    .foregroundColor(Constants.POMAGRANATE)
                            }
                        }
                        
                        HStack {
                            Toggle(isOn: $isForfeitMatch) {
                                Text("Forfeit Match")
                            }
                            .frame(width: 300)
                            
                            if isForfeitMatch {
                                Text("Match Will Be Forfeited!")
                                    .font(.callout)
                                    .padding(.leading, 20)
                                    .foregroundColor(Constants.POMAGRANATE)
                            }
                        }
                        
                        HStack {
                            Toggle(isOn: $isPointToOpposingTeam) {
                                Text("Point To Opposing Team")
                            }
                            .frame(width: 300)
                            
                            if isForfeitMatch {
                                Text("Point Will Be Added to Opposing Team Score!")
                                    .font(.callout)
                                    .padding(.leading, 20)
                                    .foregroundColor(Constants.POMAGRANATE)
                            }
                        }
                    }
                    .font(.headline)
                    
                    Button {
                        
                        if isFoulAssessed {
                            dismiss()
                        } else {
                            scoresheetManager.lastActionType = Constants.LAST_ACTION_TYPE_VIOLATION
                            scoresheetManager.lastActionScore = 66
                            scoresheetManager.lastActionGameNumber = match.currentGameNumber
                            scoresheetManager.lastActionIsSecondServer = match.isSecondServer
                            scoresheetManager.lastActionPlayerNumber = selectedFoulingPlayer
                            
                            if isSecondTechnicalFoul(playerNumber: selectedFoulingPlayer) {
                                // Automatic forfeiture of match due to 2 fouls
                                print("Automatic forfeiture of match due to 2 fouls - calling forfeitMatch()")
                                forfeitMatch()
                            } else {
                                // Create new technical foul violation, save it to realm and update match with violation
                                let newViolation = Violation()
                                newViolation.isWarning = false
                                newViolation.playerNumber = selectedFoulingPlayer
                                newViolation.violation = selectedFoul
                                newViolation.violationDescription = foulDescription
                                newViolation.gameNumber = match.currentGameNumber
                                realmManager.saveViolation(newViolation)
                                switch newViolation.playerNumber {
                                case 1:
                                    if !match.isShowViolation1Tm1 {
                                        $match.isShowViolation1Tm1.wrappedValue = true
                                    } else if !match.isShowViolation2Tm1 {
                                        $match.isShowViolation2Tm1.wrappedValue = true
                                    } else if !match.isShowViolation3Tm1 {
                                        $match.isShowViolation3Tm1.wrappedValue = true
                                    } else {
                                        print("Error in setting violations case 1 display in TechnicalFoulView")
                                    }
                                case 2:
                                    if !match.isShowViolation1Tm1 {
                                        $match.isShowViolation1Tm1.wrappedValue = true
                                    } else if !match.isShowViolation2Tm1 {
                                        $match.isShowViolation2Tm1.wrappedValue = true
                                    } else if !match.isShowViolation3Tm1 {
                                        $match.isShowViolation3Tm1.wrappedValue = true
                                    } else {
                                        print("Error in setting violations case 2 display in TechnicalFoulView")
                                    }
                                case 3:
                                    if !match.isShowViolation1Tm2 {
                                        $match.isShowViolation1Tm2.wrappedValue = true
                                    } else if !match.isShowViolation2Tm2 {
                                        $match.isShowViolation2Tm2.wrappedValue = true
                                    } else if !match.isShowViolation3Tm2 {
                                        $match.isShowViolation3Tm2.wrappedValue = true
                                    } else {
                                        print("Error in setting violations case 3 display in TechnicalFoulView")
                                    }
                                case 4:
                                    if !match.isShowViolation1Tm2 {
                                        $match.isShowViolation1Tm2.wrappedValue = true
                                    } else if !match.isShowViolation2Tm2 {
                                        $match.isShowViolation2Tm2.wrappedValue = true
                                    } else if !match.isShowViolation3Tm2 {
                                        $match.isShowViolation3Tm2.wrappedValue = true
                                    } else {
                                        print("Error in setting violations case 4 display in TechnicalFoulView")
                                    }
                                default:
                                    print("Error setting isShowViolation1Tm1 in Warning button tapped in TechnicalFoulView")
                                }
                                if isPointToOpposingTeam {
                                    print("In isPointToOpposingTeam in TechnicalFoulView")
                                    addPointToOposingTeamScore()
                                }
                                if isForfeitGame {
                                    print("In isForfeitGame in TechnicalFoulView")
                                    forfeitGame()
                                }
                                if isForfeitMatch {
                                    print("In isForfeitMatch in TechnicalFoulView")
                                    forfeitMatch()
                                }
                                
                                isFoulAssessed = true
                            }
                            
                            // Add point to opposing team score
                            // call pointScored() for team
                            // match.servingPlayerNumber
                            // match.isSecondServer
                            // Second technical fould = expulsion from tournament
                        }
                    } label: {
                        if isFoulAssessed {
                            Text("Close")
                        } else {
                            Text("Assess Foul")
                        }
                    }
                    .padding(20)
                    .buttonStyle(WideButtonStyle())
                    .disabled(selectedFoulingPlayer == 0 || selectedFoul == 0)
                }  // VStack
                .frame(width: 630)
                .background(Constants.BACKGROUND_COLOR)
                .cornerRadius(16)
                
                ViolationStatusView(match: match)
                
            }  // VStack
            .padding(.horizontal, 10)
            
            Spacer()
            VStack {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
        }  // Top VStack
        .padding()
        
    }
    
    func forfeitGame() {
        print("Starting forfeitGame in TechnicalFoulView")
        
    }
    
    func forfeitMatch() {
        print("Starting forfeitMatch in TechnicalFoulView")
        
    }
    
    func isSecondTechnicalFoul(playerNumber: Int) -> Bool {
        
        let team1Violations = realm.objects(Match.self).where { ($0.isCompleted == false && $0.violations.isWarning == false && ($0.violations.playerNumber == 1 || $0.violations.playerNumber == 2)) }
        let team2Violations = realm.objects(Match.self).where { ($0.isCompleted == false && $0.violations.isWarning == false && ($0.violations.playerNumber == 3 || $0.violations.playerNumber == 4)) }
        
        //        print ("team1Violations in isSecondTechnicalFoul: \(team1Violations.count)")
        //        print ("team2Violations in isSecondTechnicalFoul: \(team2Violations.count)")
        
        if team1Violations.count > 0 && (playerNumber == 1 || playerNumber == 2) {
            print("Team 1 already has 1 technical foul")
            return true
        } else if team2Violations.count > 0  && (playerNumber == 3 || playerNumber == 4) {
            print("Team 2 already has 1 technical foul")
            return true
        }
        return false
    }
    
    func addPointToOposingTeamScore() {
        
        // TODO: - Find way to call PointScored to give point to opposing team
        switch selectedFoulingPlayer {
        case 1, 2:
            $match.games[match.currentGameArrayIndex].player3Points.wrappedValue += 1
        case 3, 4:
            $match.games[match.currentGameArrayIndex].player1Points.wrappedValue += 1
        default:
            print("Error adding point to opposing team in TechnicalFoulView")
        }
        // TODO: - Mark image for point scored.
        // $match.images[0].point1Game1ImageTm1.wrappedValue = Constants.BOX_LEFT_BACK_SLASH
    }
}

struct TechnicalFoulView_Previews: PreviewProvider {
    static var previews: some View {
        TechnicalFoulView(match: Match())
    }
}

