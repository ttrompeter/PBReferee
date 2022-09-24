//
//  MatchOver.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/23/22.
//

import RealmSwift
import SwiftUI

struct MatchOverView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @EnvironmentObject var sheetManager: SheetManager
    @ObservedRealmObject var match: Match
    @State private var showStatisticsView = false
    @FocusState private var matchOverInFocus: matchOverFocusable?
    
    var game1Score: String {
        var game1Score = ""
        let finalGameScores = match.matchFinalGameScores
        var components = finalGameScores.components(separatedBy: " | ")
        if components.count > 0 {
            game1Score = components.removeFirst()
        } else {
            print("Error determining game1Score in MatchOverView.")
        }
        return game1Score
    }
    var game2Score: String {
        var game2Score = ""
        let finalGameScores = match.matchFinalGameScores
        var components = finalGameScores.components(separatedBy: " | ")
        if components.count > 0 {
            game2Score = components.remove(at: 1)
        } else {
            print("Error determining game2Score in MatchOverView.")
        }
        return game2Score
    }
    var game3Score: String {
        var game3Score = ""
        let finalGameScores = match.matchFinalGameScores
        var components = finalGameScores.components(separatedBy: " | ")
        if components.count > 0 {
            game3Score = components.remove(at: 2)
        } else {
            print("Error determining game3Score in MatchOverView.")
        }
        return game3Score
    }
    var game4Score: String {
        var game4Score = ""
        let finalGameScores = match.matchFinalGameScores
        var components = finalGameScores.components(separatedBy: " | ")
        if components.count > 0 {
            game4Score = components.remove(at: 3)
        } else {
            print("Error determining game4Score in MatchOverView.")
        }
        return game4Score
    }
    var game5Score: String {
        var game5Score = ""
        let finalGameScores = match.matchFinalGameScores
        var components = finalGameScores.components(separatedBy: " | ")
        if components.count > 4 {
            game5Score = components.remove(at: 4)
        } else {
            print("Error determining game5Score in MatchOverView.")
        }
        return game5Score
    }
    
    enum matchOverFocusable: Hashable {
        case initials
    }
    
    var body: some View {
        
        VStack {
            
            Text("Match is Over")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Constants.DARK_SLATE)
                .padding(.top, 30)
            
            VStack {
                VStack (spacing: 15) {
                    Text("Winning Team")
                    Text(match.matchWinner)
                    Text("Match Score: \(match.matchFinalScore)")
                    if match.selectedMatchFormat == 1 {
                        Text("Final Game Scores: \(game1Score)")
                    } else if match.selectedMatchFormat == 2 {
                        Text("Final Game Scores: \(game1Score) | \(game2Score) | \(game3Score)")
                    } else if match.selectedMatchFormat == 3 {
                        Text("Final Game Scores: \(game1Score) | \(game2Score) | \(game3Score) | \(game4Score) | \(game5Score)")
                    }
                    Text("Match Duration: \(formatElapsedTimeMinutes(value: (match.matchDuration))) Minutes")
                }
                .padding(20)
                .font(.title2)
                .foregroundColor(Constants.MINT_LEAF)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Constants.MINT_LEAF, lineWidth: 3)
                )
                
                VStack {
                    Text("Losing Team: ")
                    Text(match.matchLoser)
                }
                .padding(10)
                .font(.title2)
                .foregroundColor(Constants.DARK_SLATE)
            }
            .padding(.vertical, 20)
            
            VStack {
                HStack {
                    Text("Winning Team Player Initials: ")
                    TextField("Initials", text: $scoresheetManager.playerInitials)
                        .frame(width: 60)
                        .foregroundColor(Constants.POMAGRANATE)
                        .keyboardType(.numberPad)
                        .focused($matchOverInFocus, equals: .initials)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                self.matchOverInFocus = .initials
                            }
                        }
                        .onSubmit {
                            dismiss()
                        }
                }
                .padding(.top, 20)
                .font(.title)
                .foregroundColor(Constants.POMAGRANATE)
            }
            
            Spacer()
            HStack (spacing: 40) {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 20)
        }  // End top VStack
    }
    
    func formatElapsedTimeMinutes(value: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        let number = NSNumber(value: value)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }
    
}

struct MatchOverView_Previews: PreviewProvider {
    static var previews: some View {
        MatchOverView(match: Match())
    }
}

