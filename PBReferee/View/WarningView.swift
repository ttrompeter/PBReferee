//
//  WarningView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/21/22.
//

import RealmSwift
import SwiftUI

struct WarningView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @EnvironmentObject var sheetManager: SheetManager
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var match: Match
    
    @State private var isShowTechnicalFoul = false
    @State private var isWarningAssessed = false
    @State private var presentSecondWarningAlert = false
    @State private var selectedWarnedPlayer = 0
    @State private var selectedWarning = 0
    @State private var warningDescription = ""
    @FocusState private var warningDescriptionInFocus: warningDescriptionFocusable?
    
//    init() {
//        UITextView.appearance().backgroundColor = .clear
//    }
    
    enum warningDescriptionFocusable: Hashable {
        case descriptionText
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    Text("Warning")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(Constants.DARK_SLATE)
                    Image("yellowcard128")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipped()
                }
                .padding(.vertical, 10)
                
                VStack {
                    VStack {
                        Text("Issue A Warning")
                            .font(.title)
                            .padding(.top, 10)
                        
                        VStack (alignment: .leading) {
                            
                            HStack {
                                Text("Player: ")
                                Picker(selection: $selectedWarnedPlayer,
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
                                .onChange(of: selectedWarnedPlayer) { tag in
                                    if isSecondWarning(playerNumber: selectedWarnedPlayer) {
                                        // Show alert with link to Technical Foul page for further action
                                        presentSecondWarningAlert.toggle()
                                    }
                                }
                            }
                            
                            HStack {
                                Text("Violation: ")
                                Picker(selection: $selectedWarning,
                                       label: Text(" "),
                                       content:  {
                                    Text("Select Violation").tag(0)
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
                                        Text("Other Unsportsman Behavior").tag(10)
                                    }
                                })
                                .pickerStyle(MenuPickerStyle())
                                //.fixedSize()
                            }
                            
                            HStack (alignment: .top) {
                                Text("Violation Description: ")
                                TextField("Description", text: $warningDescription)
                                    .focused($warningDescriptionInFocus, equals: .descriptionText)
                                    .frame(width: 260)
                                    .foregroundColor(.secondary)
                                    .background(Constants.CLOUDS)
                                    .padding(.horizontal)
                            }
                        }
                        .font(.headline)
                        
                        Button {
                            
                            if isWarningAssessed {
                                dismiss()
                            } else {
                                scoresheetManager.lastActionType = Constants.LAST_ACTION_TYPE_VIOLATION
                                scoresheetManager.lastActionScore = 55
                                scoresheetManager.lastActionGameNumber = match.currentGameNumber
                                scoresheetManager.lastActionIsSecondServer = match.isSecondServer
                                scoresheetManager.lastActionPlayerNumber = selectedWarnedPlayer
                                
                                // If second warning then automatic technical foul
                                // Don't create a warning and transfer to technical foul page
                                if isSecondWarning(playerNumber: selectedWarnedPlayer) {
                                    // Show alert with link to Technical Foul page for further action
                                    presentSecondWarningAlert.toggle()
                                } else {
                                    // Create new warning violation, save it to realm and update match with violation
                                    let newViolation = Violation()
                                    newViolation.isWarning = true
                                    newViolation.playerNumber = selectedWarnedPlayer
                                    newViolation.violation = selectedWarning
                                    newViolation.violationDescription = warningDescription
                                    newViolation.gameNumber = match.currentGameNumber
                                    realmManager.saveViolation(newViolation)
                                    setShowViolation(violation: newViolation)
                                }
                                isWarningAssessed = true
                            }
                        } label: {
                            if isWarningAssessed {
                                Text("Close")
                            } else {
                                Text("Assess Warning")
                            }
                        }
                        .padding(20)
                        .buttonStyle(WideButtonStyle())
                        
                        .disabled(selectedWarnedPlayer == 0 || selectedWarning == 0)
                        .alert("2nd Warning", isPresented: $presentSecondWarningAlert) {
                            Button("Show Technical Foul", role: .cancel) {
                                isShowTechnicalFoul.toggle()
                            }
                        } message: {
                            Text("Automatic Technical Foul\nTake further action as appropriate")
                        }
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
                
            }  // End Top VStack
            .padding()
            .sheet(isPresented: $isShowTechnicalFoul) { TechnicalFoulView(match: match) }
            
        }  // End NavigationView
        .navigationViewStyle(.stack)
        .statusBar(hidden: true)
    }
        
    func isSecondWarning(playerNumber: Int) -> Bool {
        
        let team1Violations = realm.objects(Match.self).where { ($0.isCompleted == false && $0.violations.isWarning == true && ($0.violations.playerNumber == 1 || $0.violations.playerNumber == 2)) }
        let team2Violations = realm.objects(Match.self).where { ($0.isCompleted == false && $0.violations.isWarning == true && ($0.violations.playerNumber == 3 || $0.violations.playerNumber == 4)) }
        
        print ("team1Violations in isSecondWarning: \(team1Violations.count)")
        print ("team2Violations in isSecondWarning: \(team2Violations.count)")
        
        if team1Violations.count > 0 && (playerNumber == 1 || playerNumber == 2) {
            print("Team 1 already has 1 warning")
            return true
        } else if team2Violations.count > 0  && (playerNumber == 3 || playerNumber == 4) {
            print("Team 2 already has 1 warning")
            return true
        }
        return false
    }
    
    func setShowViolation(violation: Violation) {
        switch violation.playerNumber {
        case 1:
            if !match.isShowViolation1Tm1 {
                $match.isShowViolation1Tm1.wrappedValue = true
            } else if !match.isShowViolation2Tm1 {
                $match.isShowViolation2Tm1.wrappedValue = true
            } else if !match.isShowViolation3Tm1 {
                $match.isShowViolation3Tm1.wrappedValue = true
            } else {
                print("Error in setting violations case 1 display in WarningView")
            }
        case 2:
            if !match.isShowViolation1Tm1 {
                $match.isShowViolation1Tm1.wrappedValue = true
            } else if !match.isShowViolation2Tm1 {
                $match.isShowViolation2Tm1.wrappedValue = true
            } else if !match.isShowViolation3Tm1 {
                $match.isShowViolation3Tm1.wrappedValue = true
            } else {
                print("Error in setting violations case 2 display in WarningView")
            }
        case 3:
            if !match.isShowViolation1Tm2 {
                $match.isShowViolation1Tm2.wrappedValue = true
            } else if !match.isShowViolation2Tm2 {
                $match.isShowViolation2Tm2.wrappedValue = true
            } else if !match.isShowViolation3Tm2 {
                $match.isShowViolation3Tm2.wrappedValue = true
            } else {
                print("Error in setting violations case 3 display in WarningView")
            }
        case 4:
            if !match.isShowViolation1Tm2 {
                $match.isShowViolation1Tm2.wrappedValue = true
            } else if !match.isShowViolation2Tm2 {
                $match.isShowViolation2Tm2.wrappedValue = true
            } else if !match.isShowViolation3Tm2 {
                $match.isShowViolation3Tm2.wrappedValue = true
            } else {
                print("Error in setting violations case 4 display in WarningView")
            }
        default:
            print("Error setting isShowViolation1Tm1 in Warning button tapped in WarningView")
        }
    }
}

struct WarningView_Previews: PreviewProvider {
    static var previews: some View {
        WarningView(match: Match())
    }
}

