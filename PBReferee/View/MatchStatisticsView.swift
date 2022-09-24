//
//  MatchStatisticsView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/28/22.
//

import RealmSwift
import SwiftUI

struct MatchStatisticsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var match: Match
    
    private var winningTeamPlayer1FirstName: String {
        if match.matchWinningTeam == 1 {
            return match.player1FirstName
        } else {
            return match.player3FirstName
        }
    }
    private var winningTeamPlayer2FirstName: String {
        if match.matchWinningTeam == 1 {
            return match.player2FirstName
        } else {
            return match.player4FirstName
        }
    }
    private var losingTeamPlayer1FirstName: String {
        if match.matchWinningTeam == 1 {
            return match.player3FirstName
        } else {
            return match.player1FirstName
        }
    }
    private var losingTeamPlayer2FirstName: String {
        if match.matchWinningTeam == 1 {
            return match.player4FirstName
        } else {
            return match.player2FirstName
        }
    }
    private var winningTeamPlayer1FullName: String {
        if match.matchWinningTeam == 1 {
            return match.namePlayer1Team1
        } else {
            return match.namePlayer1Team2
        }
    }
    private var winningTeamPlayer2FullName: String {
        if match.matchWinningTeam == 1 {
            return match.namePlayer2Team1
        } else {
            return match.namePlayer2Team2
        }
    }
    private var losingTeamPlayer1FullName: String {
        if match.matchWinningTeam == 1 {
            return match.namePlayer1Team2
        } else {
            return match.namePlayer1Team1
        }
    }
    private var losingTeamPlayer2FullName: String {
        if match.matchWinningTeam == 1 {
            return match.namePlayer2Team2
        } else {
            return match.namePlayer2Team1
        }
    }
    private var matchPointsWinningTeamPlayer1: String {
        var totalPlayerPoints = 0
        if match.matchWinningTeam == 1 {
            totalPlayerPoints = match.games[0].player1Points + match.games[1].player1Points + match.games[2].player1Points + match.games[2].player1Points + match.games[4].player1Points
        } else {
            totalPlayerPoints = match.games[0].player3Points + match.games[1].player3Points + match.games[2].player3Points + match.games[2].player3Points + match.games[4].player3Points
        }
        return String("\(totalPlayerPoints)")
    }
    private var matchPointsWinningTeamPlayer2: String {
        var totalPlayerPoints = 0
        if match.matchWinningTeam == 1 {
            totalPlayerPoints = match.games[0].player2Points + match.games[1].player2Points + match.games[2].player2Points + match.games[2].player2Points + match.games[4].player2Points
        } else {
            totalPlayerPoints = match.games[0].player4Points + match.games[1].player4Points + match.games[2].player4Points + match.games[2].player4Points + match.games[4].player4Points
        }
        return String("\(totalPlayerPoints)")
    }
    private var matchPointsLosingTeamPlayer1: String {
        var totalPlayerPoints = 0
        if match.matchWinningTeam == 1 {
            totalPlayerPoints = match.games[0].player3Points + match.games[1].player3Points + match.games[2].player3Points + match.games[2].player3Points + match.games[4].player3Points
        } else {
            totalPlayerPoints = match.games[0].player1Points + match.games[1].player1Points + match.games[2].player1Points + match.games[2].player1Points + match.games[4].player1Points
        }
        return String("\(totalPlayerPoints)")
    }
    private var matchPointsLosingTeamPlayer2: String {
        var totalPlayerPoints = 0
        if match.matchWinningTeam == 1 {
            totalPlayerPoints = match.games[0].player4Points + match.games[1].player4Points + match.games[2].player4Points + match.games[2].player4Points + match.games[4].player4Points
        } else {
            totalPlayerPoints = match.games[0].player2Points + match.games[1].player2Points + match.games[2].player2Points + match.games[2].player2Points + match.games[4].player2Points
        }
        return String("\(totalPlayerPoints)")
    }
    
    var body: some View {
        
        VStack (spacing: 30) {
            
                VStack (alignment: .leading) {
                    HStack (alignment: .top) {
                        VStack {
                            Text("Match Results: ")
                            Divider()
                            Text(match.matchFinalScore)
                            Text(" ")
                        }
                        VStack {
                            Text("Winning Team")
                            Divider()
                            Text(winningTeamPlayer1FullName)
                                .lineLimit(1)
                            Text(winningTeamPlayer2FullName)
                                .lineLimit(1)
                        }
                        VStack {
                            Text("Losing Team")
                            Divider()
                            Text(losingTeamPlayer1FullName)
                                .lineLimit(1)
                            Text(losingTeamPlayer2FullName)
                                .lineLimit(1)
                        }
                        VStack {
                            Text("Match Format")
                            Divider()
                            Text(match.matchFormatDescription)
                            Text("To \(match.selectedPointsToWin) Points")
                        }
                    }
                    .padding(6)
                    .font(.footnote)
                    .background(Constants.BACKGROUND_COLOR)
                    .cornerRadius(8)
                    
                    HStack (alignment: .top) {
                        VStack {
                            Text("Winning Team: ")
                            //Text(" ")
                            Divider()
                            Text("Losing Team: ")
                            //Text(" ")
                        }
                        VStack {
                            Text("\(match.matchTotalPointsWinningTeam) Points")
                            //Text(" ")
                            Divider()
                            Text("\(match.matchTotalPointsLosingTeam) Points")
                            //Text(" ")
                        }
                        VStack {
                            Text("\(winningTeamPlayer1FirstName) (\(matchPointsWinningTeamPlayer1))")
                            //Text(matchPointsWinningTeamPlayer1)
                            Divider()
                            Text("\(losingTeamPlayer1FirstName) (\(matchPointsLosingTeamPlayer1))")
                            //Text(losingTeamPlayer1FirstName)
                            //Text(matchPointsLosingTeamPlayer1)
                        }
                        VStack {
                            Text("\(winningTeamPlayer2FirstName) (\(matchPointsWinningTeamPlayer2))")
                            //Text(winningTeamPlayer2FirstName)
                            //Text(matchPointsWinningTeamPlayer2)
                            Divider()
                            Text("\(losingTeamPlayer2FirstName) (\(matchPointsLosingTeamPlayer2))")
                            //Text(losingTeamPlayer2FirstName)
                            //Text(matchPointsLosingTeamPlayer2)
                        }
                    }
                    .padding(6)
                    .font(.footnote)
                    .background(Constants.BACKGROUND_COLOR)
                    .cornerRadius(8)
                    
                    HStack (alignment: .top) {
                        VStack (alignment: .leading) {
                            Text("Score By Game: ")
                            Text(" ")
                            Divider()
                            Text("Team 1: ")
                            Text("X")
                                .foregroundColor(Constants.LIGHT_GRAY)
                            Divider()
                            Text("Team 2: ")
                            Text("X")
                                .foregroundColor(Constants.LIGHT_GRAY)
                        }
                        VStack {
                            Text("Game 1")
                            Text(match.games[0].gameFinalScore)
                            Divider()
                            Text("\(match.player1FirstName) (\(match.games[0].player1Points))")
                            Text("\(match.player2FirstName) (\(match.games[0].player2Points))")
                            Divider()
                            Text("\(match.player3FirstName) (\(match.games[0].player3Points))")
                            Text("\(match.player4FirstName) (\(match.games[0].player4Points))")
                        }
                        VStack {
                            Text("Game 2")
                            Text(match.games[1].gameFinalScore)
                            Divider()
                            Text("\(match.player1FirstName) (\(match.games[1].player1Points))")
                            Text("\(match.player2FirstName) (\(match.games[1].player2Points))")
                            Divider()
                            Text("\(match.player3FirstName) (\(match.games[1].player3Points))")
                            Text("\(match.player4FirstName) (\(match.games[1].player4Points))")
                        }
                        VStack {
                            Text("Game 3")
                            Text(match.games[2].gameFinalScore)
                            Divider()
                            Text("\(match.player1FirstName) (\(match.games[2].player1Points))")
                            Text("\(match.player2FirstName) (\(match.games[2].player2Points))")
                            Divider()
                            Text("\(match.player3FirstName) (\(match.games[2].player3Points))")
                            Text("\(match.player4FirstName) (\(match.games[2].player4Points))")
                        }
                        if match.selectedPointsToWin == 3 {
                            VStack {
                                Text("Game 4")
                                Text(match.games[3].gameFinalScore)
                                Divider()
                                Text("\(match.player1FirstName) (\(match.games[3].player1Points))")
                                Text("\(match.player2FirstName) (\(match.games[3].player2Points))")
                                Divider()
                                Text("\(match.player3FirstName) (\(match.games[3].player3Points))")
                                Text("\(match.player4FirstName) (\(match.games[3].player4Points))")
                            }
                            VStack {
                                Text("Game 5")
                                Text(match.games[4].gameFinalScore)
                                Divider()
                                Text("\(match.player1FirstName) (\(match.games[4].player1Points))")
                                Text("\(match.player2FirstName) (\(match.games[4].player2Points))")
                                Divider()
                                Text("\(match.player3FirstName) (\(match.games[4].player3Points))")
                                Text("\(match.player4FirstName) (\(match.games[4].player4Points))")
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
    
}




struct MatchStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchStatisticsView(match: Match())
    }
}


//HStack (alignment: .top) {
//    VStack {
//        Text("Match Results: ")
//        Divider()
//        Text(match.matchFinalScore)
//        Text(" ")
//        Divider()
//        Text("Winning Team: ")
//        Text(" ")
//        Divider()
//        Text("Losing Team: ")
//        Text(" ")
//    }
//    VStack {
//        Text("Winning Team")
//        Divider()
//        Text(winningTeamPlayer1FullName)
//            .lineLimit(1)
//        Text(winningTeamPlayer2FullName)
//            .lineLimit(1)
//        Divider()
//        Text("\(match.matchTotalPointsWinningTeam) Points")
//        Text(" ")
//        Divider()
//        Text("\(match.matchTotalPointsLosingTeam) Points")
//        Text(" ")
//    }
//    VStack {
//        Text("Losing Team")
//        Divider()
//        Text(losingTeamPlayer1FullName)
//            .lineLimit(1)
//        Text(losingTeamPlayer2FullName)
//            .lineLimit(1)
//        Divider()
//        Text(winningTeamPlayer1FirstName)
//        Text(matchPointsWinningTeamPlayer1)
//        Divider()
//        Text(losingTeamPlayer1FirstName)
//        Text(matchPointsLosingTeamPlayer1)
//    }
//    VStack {
//        Text(" ")
//        Divider()
//        Text(match.matchFormatDescription)
//        Text("To \(match.selectedGameFormat) Points")
//        Divider()
//        Text(winningTeamPlayer2FirstName)
//        Text(matchPointsWinningTeamPlayer1)
//        Divider()
//        Text(losingTeamPlayer2FirstName)
//        Text(matchPointsLosingTeamPlayer2)
//    }
//}
//.padding(6)
//.font(.footnote)
//.background(Constants.BACKGROUND_COLOR)
//.cornerRadius(8)

