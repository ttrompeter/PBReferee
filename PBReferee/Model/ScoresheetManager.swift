//
//  ScoresheetManager.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/24/22.
//

import RealmSwift
import Foundation

final class ScoresheetManager: ObservableObject {
   
    @Published var isDefaultRefereeNameSet = false
    @Published var isGameFirstServerSet = false
    @Published var isGameStarted = false
    @Published var isGameStartReady = true      // Should be false for default
    @Published var isGameWinner = false
    @Published var isNewGameCreated = false
    @Published var isNewMatchCreated = false
    
    // These boolean values are used in MatchView to setup the match at the beginning when checking that starting server has been set.
    // They are not used during play so they can stay here and don't need to be in Match object
    @Published var isMatchStartingServerSet = true  // Shoud be false for default
    @Published var isMatchWinner = false
    @Published var isScreenOrientationCorrect = true  // Should be false for default
    
    @Published var isShowScoresheetImage = true
    @Published var isShowStatisticsAdminView = false
    @Published var isShowMatchSetup = false
    @Published var isStartNewMatch = false
    @Published var isTimeOutTaken = false
    @Published var lastActionGameNumber = 0
    @Published var lastActionPlayerNumber = 0
    @Published var lastActionIsSecondServer = true
    @Published var lastActionScore = 0
    @Published var lastActionType = ""
    @Published var lastActionViolationId = ""
    @Published var player1FoulsCount = 0
    @Published var player2FoulsCount = 0
    @Published var player3FoulsCount = 0
    @Published var player4FoulsCount = 0
    @Published var player1WarningsCount = 0
    @Published var player2WarningsCount = 0
    @Published var player3WarningsCount = 0
    @Published var player4WarningsCount = 0
    @Published var playerInitials = ""
    @Published var presentInitialsAlert = false
    
    // These name values are used in MatchView to setup the match at the beginning when checking that starting server has been set.
    // They are not used during play so they can stay here and don't need to be in Match object
    @Published var team1MatchStartingServerName = ""
    @Published var team2MatchStartingServerName = ""


//    func updateScore(match: Match) {
//
//        let tm1Score = (match.games[match.currentGameArrayIndex].player1Points) + (match.games[match.currentGameArrayIndex].player2Points)
//        let tm2Score = (match.games[match.currentGameArrayIndex].player3Points) + (match.games[match.currentGameArrayIndex].player4Points)
//        let server = match.isSecondServer == true ? "2" : "1"
//
//        if match.isTeam1Serving {
//            match.scoreDisplay = "\(tm1Score) - \(tm2Score) - \(server)"
//        } else {
//            match.scoreDisplay = "\(tm2Score) - \(tm1Score) - \(server)"
//        }
//    }
    
}

// to format string from Int - String(format: "%02d", minutes


