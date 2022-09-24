//
//  MatchStatisticsII.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/28/22.
//

import RealmSwift
import SwiftUI

struct MatchStatisticsIIView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var match: Match
    
    private var totalMatchTimeoutsTeam1: String {
        let totalTimeouts = match.games[0].timeOutsTeam1 + match.games[1].timeOutsTeam1 + match.games[2].timeOutsTeam1 + match.games[3].timeOutsTeam1 + match.games[4].timeOutsTeam1
        return String(totalTimeouts)
    }
    private var totalMatchTimeoutsTeam2: String {
        let totalTimeouts = match.games[0].timeOutsTeam2 + match.games[1].timeOutsTeam2 + match.games[2].timeOutsTeam2 + match.games[3].timeOutsTeam2 + match.games[4].timeOutsTeam2
        return String(totalTimeouts)
    }
    private var totalMatchSideoutsTeam1: String {
        let totalSideouts = match.games[0].sideOutsTeam1 + match.games[1].sideOutsTeam1 + match.games[2].sideOutsTeam1 + match.games[3].sideOutsTeam1 + match.games[4].sideOutsTeam1
        return String(totalSideouts)
    }
    private var totalMatchSideoutsTeam2: String {
        let totalSideouts = match.games[0].sideOutsTeam2 + match.games[1].sideOutsTeam2 + match.games[2].sideOutsTeam2 + match.games[3].sideOutsTeam2 + match.games[4].sideOutsTeam2
        return String(totalSideouts)
    }
    
//    private var matchTotalViolationsTeam1: String {
//        let totalViolations = match.games[0].warningsTeam1 + match.games[0].technicalFoulsTeam1 + match.games[1].warningsTeam1 + match.games[1].technicalFoulsTeam1 + match.games[2].warningsTeam1 + match.games[2].technicalFoulsTeam1 + match.games[3].warningsTeam1 + match.games[3].technicalFoulsTeam1 + match.games[4].warningsTeam1 + match.games[4].technicalFoulsTeam1
//        return String(totalViolations)
//    }
//    private var matchTotalViolationsTeam2: String {
//        let totalViolations = match.games[0].warningsTeam2 + match.games[0].technicalFoulsTeam2 + match.games[1].warningsTeam2 + match.games[1].technicalFoulsTeam2 + match.games[2].warningsTeam2 + match.games[2].technicalFoulsTeam2 + match.games[3].warningsTeam2 + match.games[3].technicalFoulsTeam2 + match.games[4].warningsTeam2 + match.games[4].technicalFoulsTeam2
//        return String(totalViolations)
//    }
    
    private var matchTotalWarningsTeam1: String {
        return "\(realmManager.getPlayerWarningsCountForMatch(playerNumber: 1) + realmManager.getPlayerWarningsCountForMatch(playerNumber: 2))"
    }
    private var matchTotalWarningsTeam2: String {
        return "\(realmManager.getPlayerWarningsCountForMatch(playerNumber: 3) + realmManager.getPlayerWarningsCountForMatch(playerNumber: 4))"
    }
    private var matchTotalFoulsTeam1: String {
        return "\(realmManager.getPlayerFoulsCountForMatch(playerNumber: 1) + realmManager.getPlayerFoulsCountForMatch(playerNumber: 2))"
    }
    private var matchTotalFoulsTeam2: String {
        return "\(realmManager.getPlayerFoulsCountForMatch(playerNumber: 3) + realmManager.getPlayerFoulsCountForMatch(playerNumber: 4))"
    }
    private var game1WarningsTeam1: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 1, gameNumber: 1) + realmManager.getPlayerWarningsCountForGame(playerNumber: 2, gameNumber: 1))"
    }
    private var game2WarningsTeam1: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 1, gameNumber: 2) + realmManager.getPlayerWarningsCountForGame(playerNumber: 2, gameNumber: 2))"
    }
    private var game3WarningsTeam1: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 1, gameNumber: 3) + realmManager.getPlayerWarningsCountForGame(playerNumber: 2, gameNumber: 3))"
    }
    private var game4WarningsTeam1: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 1, gameNumber: 4) + realmManager.getPlayerWarningsCountForGame(playerNumber: 2, gameNumber: 4))"
    }
    private var game5WarningsTeam1: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 1, gameNumber: 5) + realmManager.getPlayerWarningsCountForGame(playerNumber: 2, gameNumber: 5))"
    }
    private var game1WarningsTeam2: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 3, gameNumber: 1) + realmManager.getPlayerWarningsCountForGame(playerNumber: 4, gameNumber: 1))"
    }
    private var game2WarningsTeam2: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 3, gameNumber: 2) + realmManager.getPlayerWarningsCountForGame(playerNumber: 4, gameNumber: 2))"
    }
    private var game3WarningsTeam2: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 3, gameNumber: 3) + realmManager.getPlayerWarningsCountForGame(playerNumber: 4, gameNumber: 3))"
    }
    private var game4WarningsTeam2: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 3, gameNumber: 4) + realmManager.getPlayerWarningsCountForGame(playerNumber: 4, gameNumber: 4))"
    }
    private var game5WarningsTeam2: String {
        return "\(realmManager.getPlayerWarningsCountForGame(playerNumber: 3, gameNumber: 5) + realmManager.getPlayerWarningsCountForGame(playerNumber: 4, gameNumber: 5))"
    }
    private var game1FoulsTeam1: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 1, gameNumber: 1) + realmManager.getPlayerFoulsCountForGame(playerNumber: 2, gameNumber: 1))"
    }
    private var game2FoulsTeam1: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 1, gameNumber: 2) + realmManager.getPlayerFoulsCountForGame(playerNumber: 2, gameNumber: 2))"
    }
    private var game3FoulsTeam1: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 1, gameNumber: 3) + realmManager.getPlayerFoulsCountForGame(playerNumber: 2, gameNumber: 3))"
    }
    private var game4FoulsTeam1: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 1, gameNumber: 4) + realmManager.getPlayerFoulsCountForGame(playerNumber: 2, gameNumber: 4))"
    }
    private var game5FoulsTeam1: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 1, gameNumber: 5) + realmManager.getPlayerFoulsCountForGame(playerNumber: 2, gameNumber: 5))"
    }
    private var game1FoulsTeam2: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 3, gameNumber: 1) + realmManager.getPlayerFoulsCountForGame(playerNumber: 4, gameNumber: 1))"
    }
    private var game2FoulsTeam2: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 3, gameNumber: 2) + realmManager.getPlayerFoulsCountForGame(playerNumber: 4, gameNumber: 2))"
    }
    private var game3FoulsTeam2: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 3, gameNumber: 3) + realmManager.getPlayerFoulsCountForGame(playerNumber: 4, gameNumber: 3))"
    }
    private var game4FoulsTeam2: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 3, gameNumber: 4) + realmManager.getPlayerFoulsCountForGame(playerNumber: 4, gameNumber: 4))"
    }
    private var game5FoulsTeam2: String {
        return "\(realmManager.getPlayerFoulsCountForGame(playerNumber: 3, gameNumber: 5) + realmManager.getPlayerFoulsCountForGame(playerNumber: 4, gameNumber: 5))"
    }
    
    
    var body: some View {
        
        VStack (spacing: 30) {
            
                VStack (alignment: .leading) {
                    
                    HStack (alignment: .top) {
                        VStack (alignment: .leading) {
                            Group {
                                Text("Other Results: ")
                                Divider()
                                Text("Sideouts Team 1: ")
                                Text("Sideouts Team 2: ")
                                Divider()
                                Text("Timeouts Team 1: ")
                                Text("Timeouts Team 2: ")
                            }
                            Divider()
                            Text("Warnings Team 1: ")
                            Text("Warnings Team 2: ")
                            Text("Fouls Team 1: ")
                            Text("Fouls Team 2: ")
                            Divider()
                            Text("Elapsed Time: ")
                        }
                        VStack {
                            Group {
                                Text("Match")
                                Divider()
                                Text(totalMatchSideoutsTeam1)
                                Text(totalMatchSideoutsTeam2)
                                Divider()
                                Text(totalMatchTimeoutsTeam1)
                                Text(totalMatchTimeoutsTeam2)
                            }
                            Divider()
                            Text(matchTotalWarningsTeam1)
                            Text(matchTotalWarningsTeam2)
                            Text(matchTotalFoulsTeam1)
                            Text(matchTotalFoulsTeam2)
                            Divider()
                            Text("\(formatElapsedTimeMinutes(value: (match.matchDuration))) min")
                        }
                        VStack {
                            Group {
                                Text("Game 1")
                                Divider()
                                Text("\(match.games[0].sideOutsTeam1)")
                                Text("\(match.games[0].sideOutsTeam2)")
                                Divider()
                                Text("\(match.games[0].timeOutsTeam1)")
                                Text("\(match.games[0].timeOutsTeam2)")
                            }
                            Divider()
                            Text("\(game1WarningsTeam1)")
                            Text("\(game1WarningsTeam2)")
                            Text("\(game1FoulsTeam1)")
                            Text("\(game1FoulsTeam2)")
                            Divider()
                            Text("\(formatElapsedTimeMinutes(value: (match.games[0].gameDuration))) min")
                        }
                        VStack {
                            Group {
                                Text("Game 2")
                                Divider()
                                Text("\(match.games[1].sideOutsTeam1)")
                                Text("\(match.games[1].sideOutsTeam2)")
                                Divider()
                                Text("\(match.games[1].timeOutsTeam1)")
                                Text("\(match.games[1].timeOutsTeam2)")
                            }
                            Divider()
                            Text("\(game2WarningsTeam1)")
                            Text("\(game2WarningsTeam2)")
                            Text("\(game2FoulsTeam1)")
                            Text("\(game2FoulsTeam2)")
                            Divider()
                            Text("\(formatElapsedTimeMinutes(value: (match.games[1].gameDuration))) min")
                        }
                        VStack {
                            Group {
                                Text("Game 3")
                                Divider()
                                Text("\(match.games[2].sideOutsTeam1)")
                                Text("\(match.games[2].sideOutsTeam2)")
                                Divider()
                                Text("\(match.games[2].timeOutsTeam1)")
                                Text("\(match.games[2].timeOutsTeam2)")
                            }
                            Divider()
                            Text("\(game3WarningsTeam1)")
                            Text("\(game3WarningsTeam2)")
                            Text("\(game3FoulsTeam1)")
                            Text("\(game3FoulsTeam2)")
                            Divider()
                            Text("\(formatElapsedTimeMinutes(value: (match.games[2].gameDuration))) min")
                        }
                        if match.selectedPointsToWin == 3 {
                            VStack {
                                Group {
                                    Text("Game 4")
                                    Divider()
                                    Text("\(match.games[3].sideOutsTeam1)")
                                    Text("\(match.games[3].sideOutsTeam2)")
                                    Divider()
                                    Text("\(match.games[3].timeOutsTeam1)")
                                    Text("\(match.games[3].timeOutsTeam2)")
                                }
                                Divider()
                                Text("\(game4WarningsTeam1)")
                                Text("\(game4WarningsTeam2)")
                                Text("\(game4FoulsTeam1)")
                                Text("\(game4FoulsTeam2)")
                                Divider()
                                Text("\(formatElapsedTimeMinutes(value: (match.games[3].gameDuration))) min")
                            }
                            VStack {
                                Group {
                                    Text("Game 5")
                                    Divider()
                                    Text("\(match.games[4].sideOutsTeam1)")
                                    Text("\(match.games[4].sideOutsTeam2)")
                                    Divider()
                                    Text("\(game5FoulsTeam1)")
                                    Text("\(game5FoulsTeam2)")
                                }
                                Divider()
                                Text("\(game5WarningsTeam1)")
                                Text("\(game5WarningsTeam2)")
                                Text("\(game5FoulsTeam1)")
                                Text("\(game5FoulsTeam2)")
                                Divider()
                                Text("\(formatElapsedTimeMinutes(value: (match.games[4].gameDuration))) min")
                            }
                        }
                    }
                    .padding(6)
                    .font(.caption)
                    .background(Constants.BACKGROUND_COLOR)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 40)

        }  // Top VStack
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

struct MatchStatisticsII_Previews: PreviewProvider {
    static var previews: some View {
        MatchStatisticsIIView(match: Match())
    }
}

