//
//  MatchSetupView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//
import RealmSwift
import SwiftUI

enum matchSetupFocusable: Hashable {
    case event
    case location
    case matchNumber
    case courtNumber
    case notes
    case email
    case player1
    case player1Ids
    case player2
    case player2Ids
    case player3
    case player3Ids
    case player4
    case player4Ids
    case referee
    case asstReferee
    case lineJudge1
    case lineJudge2
    case lineJudge3
    case lineJudge4
    case trainee
    case remarks
}

struct MatchSetupView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var match: Match
    @FocusState private var matchSetupInFocus: matchSetupFocusable?
    @State private var isShowingPlayerNamesAlert = false
    @State private var emailPrompt = "Invalid Address"
    
    
    // Closed range for DatePicker for Match Date
    var closedRange: ClosedRange<Date> {
        let today = Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!
        let thirtyDaysAhead = Calendar.current.date(byAdding: .day, value: +30, to: Date.now)!
        return today...thirtyDaysAhead
    }
    
    
    var body: some View {
            
            VStack {
                
                Text("Match Setup")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Constants.DARK_SLATE)
                    .padding(.bottom, 5)
                
                VStack {
                    
                    Form {
                        
                        Section(header: Text("Match Information").bold().font(.headline)) {
                            VStack (alignment: .leading) {
                                HStack {
                                    Text("Event Title: ")
                                        .foregroundColor(Constants.DARK_SLATE)
                                    TextField("Title of Event", text: $match.eventTitle)
                                        .focused($matchSetupInFocus, equals: .event)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                                self.matchSetupInFocus = .event
                                            }
                                        }
                                }
                                HStack {
                                    Text("Match Location: ")
                                        .foregroundColor(Constants.DARK_SLATE)
                                    TextField("Match Location", text: $match.matchLocation)
                                        .focused($matchSetupInFocus, equals: .location)
                                }
                                
                                HStack (alignment: .top) {
                                    
                                    VStack (alignment: .leading) {
                                        HStack {
                                            Text("Match Number: ")
                                                .foregroundColor(Constants.DARK_SLATE)
                                            TextField("Match Number", text: $match.matchNumber)
                                                .focused($matchSetupInFocus, equals: .matchNumber)
                                                .keyboardType(.numberPad)
                                        }
                                    }
                                    
                                    VStack (alignment: .leading) {
                                        HStack {
                                            Text("Court Number: ")
                                                .foregroundColor(Constants.DARK_SLATE)
                                            TextField("Court Number", text: $match.courtNumber)
                                                .focused($matchSetupInFocus, equals: .courtNumber)
                                                .keyboardType(.numberPad)
                                        }
                                    }
                                }
                                
                                HStack {
                                    Text("Play Type:        ")
                                    Picker(selection: $match.selectedDoublesPlay,
                                           label: Text(" "),
                                           content:  {
                                        Text("Doubles").tag(2)
                                        Text("Singles").tag(1)
                                    })
                                    .pickerStyle(SegmentedPickerStyle())
                                    .fixedSize()
                                    .onAppear {
                                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0) // Silver
                                        UISegmentedControl.appearance().backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0) // Clouds
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 45/255, green: 52/255, blue: 54/255, alpha: 1.0)], for: .selected) // Dracula Orchid
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1.0)], for: .normal) // Dark Slate
                                        
                                        // SILVER = Color(red: 189/255, green: 195/255, blue: 199/255)
                                        // DARK_SLATE = Color(red: 47/255, green: 79/255, blue: 79/255)
                                        // CLOUDS = Color(red: 236/255, green: 240/255, blue: 241/255)
                                        // SLATE_GRAY = Color(red: 112/255, green: 128/255, blue: 144/255)
                                        // ASBESTOS         rgba(127, 140, 141,1.0)
                                        // DRACULA ORCHID   rgba(45, 52, 54,1.0)
                                        
                                    }
                                    Text("          ")
                                    Text("Scoring Format:   ")
                                    Picker(selection: $match.selectedScoringFormat,
                                           label: Text(" "),
                                           content:  {
                                        Text("Regular").tag(1)
                                        Text("Rally").tag(2)
                                    })
                                    .pickerStyle(SegmentedPickerStyle())
                                    .fixedSize()
                                    .onAppear {
                                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0) // Silver
                                        UISegmentedControl.appearance().backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0) // Clouds
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 45/255, green: 52/255, blue: 54/255, alpha: 1.0)], for: .selected) // Dracula Orchid
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1.0)], for: .normal) // Dark Slate
                                    }
                                }
                                
                                HStack {
                                    Text("Match Format: ")
                                    Picker(selection: $match.selectedMatchFormat,
                                           label: Text(" "),
                                           content:  {
                                        Text("2 out of 3 Games").tag(2)
                                        Text("3 out of 5 Games").tag(3)
                                        Text("Single Game").tag(1)
                                    })
                                    .pickerStyle(SegmentedPickerStyle())
                                    .fixedSize()
                                    .onAppear {
                                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0) // Silver
                                        UISegmentedControl.appearance().backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0) // Clouds
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 45/255, green: 52/255, blue: 54/255, alpha: 1.0)], for: .selected) // Dracula Orchid
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1.0)], for: .normal) // Dark Slate
                                    }
                                }
                                
                                HStack {
                                    Text("Points To Win:  ")
                                    Picker(selection: $match.selectedPointsToWin,
                                           label: Text(" "),
                                           content:  {
                                        Text("7 Points").tag(7)
                                        Text("11 Points").tag(11)
                                        Text("15 Points").tag(15)
                                        Text("21 Points").tag(21)
                                    })
                                    .pickerStyle(SegmentedPickerStyle())
                                    .fixedSize()
                                    .onAppear {
                                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0) // Silver
                                        UISegmentedControl.appearance().backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0) // Clouds
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 45/255, green: 52/255, blue: 54/255, alpha: 1.0)], for: .selected) // Dracula Orchid
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1.0)], for: .normal) // Dark Slate
                                    }
                                    Text("Win By 2 Points")
                                        .font(.subheadline)
                                }
                                
                                
                                HStack {
                                    Text("Match Notes: ")
                                        .foregroundColor(Constants.DARK_SLATE)
                                    TextField("Notes", text: $match.matchNotes)
                                        .foregroundColor(Constants.DARK_SLATE)
                                        .focused($matchSetupInFocus, equals: .notes)
                                }
                                HStack {
                                    Text("Email To Submit Scorsheet: ")
                                        .foregroundColor(Constants.DARK_SLATE)
                                    TextField("[Optional] Enter Email Address", text: $match.emailAddressForScoresheetSnaphot)
                                        .foregroundColor(Constants.DARK_SLATE)
                                        .focused($matchSetupInFocus, equals: .email)
                                        .keyboardType(.emailAddress)
                                    if !isEmailValid() {
                                        Text(emailPrompt)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .font(.caption)
                                            .foregroundColor(Constants.CRIMSON)
                                    }
                                }
                                
                            }  // Top VStack in Section
                        } // Section - Match Information
                        
                        
                        Section (header: Text("Player Information").bold().font(.headline)) {
                            
                            // TODO: - Change display based on doubles or singles
                            HStack {
                                VStack {
                                    Text("Team 1")
                                        .font(.headline)
                                    
                                    VStack (alignment: .leading) {
                                        VStack {
                                            HStack {
                                                Text("Name: ")
                                                TextField("Player Name", text: $match.namePlayer1Team1)
                                                    .focused($matchSetupInFocus, equals: .player1)
                                            }
                                            HStack {
                                                Text("Identifiers: ")
                                                TextField("Player Identifier(s)", text: $match.player1Team1Identifiers)
                                                    .focused($matchSetupInFocus, equals: .player1Ids)
                                            }
                                        }
                                        .padding()
                                        .background(Constants.CLOUDS)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        
                                        VStack {
                                            HStack {
                                                Text("Name: ")
                                                TextField("Player Name", text: $match.namePlayer2Team1)
                                                    .focused($matchSetupInFocus, equals: .player2)
                                            }
                                            HStack {
                                                Text("Identifiers: ")
                                                TextField("Player Identifier(s)", text: $match.player2Team1Identifiers)
                                                    .focused($matchSetupInFocus, equals: .player2Ids)
                                            }
                                        }
                                        .padding()
                                        .background(Constants.CLOUDS)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        
                                        VStack {
                                            HStack {
                                                Text("First Server: ")
                                                Picker(selection: $match.games[match.currentGameArrayIndex].selectedFirstServerTeam1,
                                                       label: Text(" "),
                                                       content:  {
                                                    Text(match.namePlayer1Team1).tag(1)
                                                    Text(match.namePlayer2Team1).tag(2)
                                                })
                                                .pickerStyle(MenuPickerStyle())
                                                .fixedSize()
                                            }
                                        }
                                        .padding()
                                        .background(Constants.CLOUDS)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                                
                                VStack {
                                    Text("Team 2")
                                        .font(.headline)
                                    VStack (alignment: .leading) {
                                        VStack (alignment: .leading) {
                                            HStack {
                                                Text("Name: ")
                                                TextField("Player Name", text: $match.namePlayer1Team2)
                                                    .focused($matchSetupInFocus, equals: .player3)
                                            }
                                            HStack {
                                                Text("Identifiers: ")
                                                TextField("Player Identifier(s)", text: $match.player1Team2Identifiers)
                                                    .focused($matchSetupInFocus, equals: .player3Ids)
                                            }
                                        }
                                        .padding()
                                        .background(Constants.CLOUDS)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        
                                        VStack {
                                            HStack {
                                                Text("Name: ")
                                                TextField("Player Name", text: $match.namePlayer2Team2)
                                                    .focused($matchSetupInFocus, equals: .player4)
                                            }
                                            HStack {
                                                Text("Identifiers: ")
                                                TextField("Player Identifier(s)", text: $match.player2Team2Identifiers)
                                                    .focused($matchSetupInFocus, equals: .player4Ids)
                                            }
                                        }
                                        .padding()
                                        .background(Constants.CLOUDS)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        
                                        VStack (alignment: .leading) {
                                            HStack {
                                                Text("First Server: ")
                                                Picker(selection: $match.games[match.currentGameArrayIndex].selectedFirstServerTeam2,
                                                       label: Text(" "),
                                                       content:  {
                                                    Text(match.namePlayer1Team2).tag(3)
                                                    Text(match.namePlayer2Team2).tag(4)
                                                })
                                                .pickerStyle(MenuPickerStyle())
                                                .fixedSize()
                                            }
                                        }
                                        .padding()
                                        .background(Constants.CLOUDS)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            }
                        } // Section - Player Information
                        
                        Section (header: Text("Referee Information").bold().font(.headline)) {
                            HStack {
                                
                                VStack {
                                    HStack {
                                        Text("Referee: ")
                                        TextField("Referee Name:", text: $match.games[0].refereeName)  // $match.games[0].refereeName
                                            .focused($matchSetupInFocus, equals: .referee)
                                    }
                                    HStack {
                                        Text("Line Judge 1: ")
                                        TextField("Line Judge Name:", text: $match.games[0].lineJudge1Name)
                                            .focused($matchSetupInFocus, equals: .lineJudge1)
                                    }
                                    HStack {
                                        Text("Line Judge 3: ")
                                        TextField("LineJudge Name:", text: $match.games[0].lineJudge3Name)
                                            .focused($matchSetupInFocus, equals: .lineJudge3)
                                    }
                                    HStack {
                                        Text("Trainee: ")
                                        TextField("Trainee Name:", text: $match.games[0].traineeName)
                                            .focused($matchSetupInFocus, equals: .trainee)
                                    }
                                }
                                VStack {
                                    HStack {
                                        Text("Asst Referee: ")
                                        TextField("Asst Referee Name:", text: $match.games[0].asstRefereeName)
                                            .focused($matchSetupInFocus, equals: .asstReferee)
                                    }
                                    HStack {
                                        Text("Line Judge 2: ")
                                        TextField("Line Judge Name:", text: $match.games[0].lineJudge2Name)
                                            .focused($matchSetupInFocus, equals: .lineJudge2)
                                    }
                                    HStack {
                                        Text("Line Judge 4: ")
                                        TextField("Line Judge Name: ", text: $match.games[0].lineJudge4Name)
                                            .focused($matchSetupInFocus, equals: .lineJudge4)
                                    }
                                    HStack {
                                        Text("Remarks: ")
                                        TextField("Enter Remarks: ", text: $match.matchRefereeRemarks)
                                            .focused($matchSetupInFocus, equals: .remarks)
                                    }
                                }
                            }
                        }
                        
                    } // FORM
                    .onSubmit {
                        if matchSetupInFocus == .event {
                            matchSetupInFocus = .location
                        } else if matchSetupInFocus == .location {
                            matchSetupInFocus = .matchNumber
                        } else if matchSetupInFocus == .matchNumber {
                            matchSetupInFocus = .courtNumber
                        } else if matchSetupInFocus == .courtNumber {
                            matchSetupInFocus = .notes
                        } else if matchSetupInFocus == .notes {
                            matchSetupInFocus = .email
                        } else if matchSetupInFocus == .email {
                            matchSetupInFocus = .player1
                        } else if matchSetupInFocus == .player1 {
                            matchSetupInFocus = .player1Ids
                        } else if matchSetupInFocus == .player1Ids {
                            matchSetupInFocus = .player2
                        } else if matchSetupInFocus == .player2 {
                            matchSetupInFocus = .player2Ids
                        } else if matchSetupInFocus == .player2Ids {
                            matchSetupInFocus = .player3
                        } else if matchSetupInFocus == .player3 {
                            matchSetupInFocus = .player3Ids
                        } else if matchSetupInFocus == .player3Ids {
                            matchSetupInFocus = .player4
                        } else if matchSetupInFocus == .player4 {
                            matchSetupInFocus = .player4Ids
                        } else if matchSetupInFocus == .player4Ids {
                            matchSetupInFocus = .referee
                        } else if matchSetupInFocus == .referee {
                            matchSetupInFocus = .asstReferee
                        } else if matchSetupInFocus == .asstReferee {
                            matchSetupInFocus = .lineJudge1
                        } else if matchSetupInFocus == .lineJudge1 {
                            matchSetupInFocus = .lineJudge2
                        } else if matchSetupInFocus == .lineJudge2 {
                            matchSetupInFocus = .lineJudge3
                        } else if matchSetupInFocus == .lineJudge3 {
                            matchSetupInFocus = .lineJudge4
                        } else if matchSetupInFocus == .lineJudge4 {
                            matchSetupInFocus = .trainee
                        } else if matchSetupInFocus == .trainee {
                            matchSetupInFocus = .remarks
                        } else if matchSetupInFocus == .remarks {
                            matchSetupInFocus = nil
                        }
                    }
                }  // VStack
                
                VStack {
                    HStack (spacing: 40) {
//                        Button("Cancel") {
//                            // Reset to default or existing values
//                            dismiss()
//                        }
//                        .buttonStyle(SheetButtonStyle())
                        
                        Button("Save") {
                            // Set the selectedFirstServers for all games to be the same as that selected in the MatchSetup
                            // It can be changed later using Match Setup again if a team decides to change the designated first server between games
                            $match.games[1].selectedFirstServerTeam1.wrappedValue = match.games[0].selectedFirstServerTeam1
                            $match.games[2].selectedFirstServerTeam1.wrappedValue = match.games[0].selectedFirstServerTeam1
                            $match.games[3].selectedFirstServerTeam1.wrappedValue = match.games[0].selectedFirstServerTeam1
                            $match.games[4].selectedFirstServerTeam1.wrappedValue = match.games[0].selectedFirstServerTeam1
                            
                            $match.games[1].selectedFirstServerTeam2.wrappedValue = match.games[0].selectedFirstServerTeam2
                            $match.games[2].selectedFirstServerTeam2.wrappedValue = match.games[0].selectedFirstServerTeam2
                            $match.games[3].selectedFirstServerTeam2.wrappedValue = match.games[0].selectedFirstServerTeam2
                            $match.games[4].selectedFirstServerTeam2.wrappedValue = match.games[0].selectedFirstServerTeam2
                            
                            // TODO: - Figure this out for saving to Settings
                            // Update certain Settings values to thos set in MatchSetup
                            // This is becuase a referee will likley referee several matches during an Event and this will avoid having to retype this information for each match
//                            let settings = realm.objects(Settings.self)[0]
//                            if !match.eventTitle.isEmpty {
//                                $settings.defaultEventTitle.wrappedValue = match.eventTitle
//                            }
//                            if !match.matchLocation.isEmpty {
//                                $settings.defaultLocation.wrappedValue = match.matchLocation
//                            }
//                            if !match.emailAddressForScoresheetSnaphot.isEmpty {
//                                $settings.defaultEmailAddress.wrappedValue = match.emailAddressForScoresheetSnaphot
//                            }
                            
                            $match.isMatchSetupCompleted.wrappedValue = true
                            dismiss()
                        }
                        .buttonStyle(SheetButtonStyle())
                        .disabled(match.namePlayer1Team1.isEmpty  || match.namePlayer2Team1.isEmpty || match.namePlayer1Team2.isEmpty || match.namePlayer2Team2.isEmpty)
                    }
                }
                // Empaty Text view to add space below buttons
                Text("")
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)

    }
    
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: match.emailAddressForScoresheetSnaphot)
    }
    
}



struct MatchSetupView_Previews: PreviewProvider {
    static var previews: some View {
        
        MatchSetupView(match: Match())
    }
}


