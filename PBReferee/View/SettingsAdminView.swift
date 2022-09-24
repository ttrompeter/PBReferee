//
//  SettingsView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

struct SettingsAdminView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var match: Match
    @ObservedResults(Settings.self) var settings
    
    @State private var showWelcomeScreen = false
    @State private var showGameScores = false
    @State private var setNumberOfArchivedMatches = false
    @State private var setDefaultMatchGameType = false
    @State private var setDefaultMatchFormat = false
    @State private var setDefaultMatchStyle = false
    @State private var useRallyScoring = false
    @State private var appSettings = Settings()
    @FocusState private var settingsInFocus: settingsFocusable?
    
    enum settingsFocusable: Hashable {
        case eventTitle
        case location
        case refereeName
        case emailAddress
        case userEmailAddress
    }
    
    var body: some View {
        
        VStack (spacing: 30) {
            
            Text("Settings")
                .bold()
                .padding()
                .font(.largeTitle)
                .foregroundColor(Constants.DARK_SLATE)
            
            ZStack {
                Rectangle()
                    .frame(width: CGFloat(660), height: CGFloat(500))
                    .foregroundColor(Constants.CLOUDS)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                VStack {
                    
                    Text("Adjust Pickleball Referee Application Settings")
                        .font(.headline)
                    
                    VStack (alignment: .leading) {
                        
                        Group {
                            HStack {
                                Text("Default Event Title: ")
                                TextField("Event Titla", text: $appSettings.defaultEventTitle)
                                    .frame(width: 60)
                                    .foregroundColor(Constants.POMAGRANATE)
                                    .keyboardType(.numberPad)
                                    .focused($settingsInFocus, equals: .eventTitle)
                            }
                            HStack {
                                Text("Default Location: ")
                                TextField("Location", text: $appSettings.defaultLocation)
                                    .frame(width: 60)
                                    .foregroundColor(Constants.POMAGRANATE)
                                    .keyboardType(.numberPad)
                                    .focused($settingsInFocus, equals: .location)
                            }
                            HStack {
                                Text("Default Referee Name: ")
                                TextField("Referee", text: $appSettings.defaultRefereeName)
                                    .frame(width: 60)
                                    .foregroundColor(Constants.POMAGRANATE)
                                    .keyboardType(.numberPad)
                                    .focused($settingsInFocus, equals: .refereeName)
                            }
                            HStack {
                                Text("Default Email Address: ")
                                TextField("Email", text: $appSettings.defaultEmailAddress)
                                    .frame(width: 60)
                                    .foregroundColor(Constants.POMAGRANATE)
                                    .keyboardType(.numberPad)
                                    .focused($settingsInFocus, equals: .emailAddress)
                            }
                            HStack {
                                Text("Default User Email Address: ")
                                TextField("Email", text: $appSettings.defaultUserEmailAddress)
                                    .frame(width: 60)
                                    .foregroundColor(Constants.POMAGRANATE)
                                    .keyboardType(.numberPad)
                                    .focused($settingsInFocus, equals: .userEmailAddress)
                            }
                        }
                        Toggle("Show Welcome Screen when App starts", isOn: $appSettings.isShowWelcomeScreen)
                        Toggle("Show Game scores on scoresheet", isOn: $showGameScores)
                        Toggle("Use Rally Scoring", isOn: $useRallyScoring)
                        
                        HStack {
                            Text("Default Match Format: ")
                            Picker(selection: $appSettings.selectedMatchFormat,
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
                            Text("Default Points To Win Game:  ")
                            Picker(selection: $appSettings.selectedPointsToWin,
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
                        }
                        
                        HStack {
                            Text("Default Scoring Format:   ")
                            Picker(selection: $appSettings.selectedScoringFormat,
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
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .frame(width: 600, height: 500)
            }
            
            Spacer()
            HStack (spacing: 40) {
                Button("Save") {
                    
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 20)
        }  // Top VStack
        .onAppear {
            $appSettings.wrappedValue = realm.objects(Settings.self)[0]
        }
    }
}

struct SettingsAdminView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAdminView(match: Match())
    }
}

