//
//  ScoresheetManager.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/24/22.
//

import Foundation


final class ScoresheetManager: ObservableObject {
   
    @Published var isGameCompleted = false
    @Published var isGameFirstServerSet = false
    @Published var isGameStarted = false
    @Published var isGameStartReady = true      // Should be false for default
    @Published var isGameWinner = false
    @Published var isMatchCompeted = false
    @Published var isMatchSetupComplete = true      // Should be false for default
    @Published var isMatchStarted = false
    @Published var isMatchStartingServerSet = true  // Shoud be false for default
    @Published var isMatchWinner = false
    @Published var isScreenOrientationCorrect = true  // Should be false for default
    @Published var isSecondServer = true
    @Published var isServerSideSet = true     // Should be false for default
    @Published var isServingLeftSide = false
    @Published var isStartNewMatch = false
    @Published var isTeam1Serving = true
    @Published var isTimeOutTaken = false
    @Published var isViolationTm1 = false
    @Published var isViolationTm2 = false
    @Published var isViolation1Tm1 = true     // Should be false
    @Published var isViolation2Tm1 = true     // Should be false
    @Published var isViolation3Tm1 = false
    @Published var isViolation1Tm2 = true     // Should be false
    @Published var isViolation2Tm2 = true     // Should be false
    @Published var isViolation3Tm2 = false
    @Published var lastActionGameNumber = 0
    @Published var lastActionPlayerNumber = 0
    @Published var lastActionScore = 0
    @Published var matchFinalGameScores = ""
    @Published var playerInitials = ""
    @Published var team1MatchStartingServerName = ""
    @Published var team2MatchStartingServerName = ""
    
   
    
    
    
    
    
    
//    @Published var gameDuration = 0.0
//    @Published var gameElapsedTime = 0.0
//    @Published var gameTimerStartDate = Date.now
//    @Published var gameTimerEndDate = Date.now
//    @Published var matchDuration = 0.0
//    @Published var isMatchRunning = false
//    @Published var isMatchSetupCompleted = false
//    @Published var matchElapsedTime = 0.0
//    @Published var matchTimerStartDate = Date.now
//    @Published var matchTimerEndDate = Date.now
//    @Published var team1Serving = false
//    @Published var secondsElapsedInGame = 0.0
//    @Published var secondsElapsedInMatch = 0.0
//
//
//    var gameComputedDuration: Double {
//        // Gets milliseconds
//        let gameDuration = gameTimerEndDate.timeIntervalSince(gameTimerStartDate)
//        // Return game duration in minutes
//        return (gameDuration.truncatingRemainder(dividingBy: 3600)) / 60
//    }
//
//    var matchComputedDuration: Double {
//        // Gets milliseconds
//        let matchDuration = matchTimerEndDate.timeIntervalSince(matchTimerStartDate)
//        // Return match duration in minutes
//        return (matchDuration.truncatingRemainder(dividingBy: 3600)) / 60
//    }
}

// to format string from Int - String(format: "%02d", minutes

//final class SheetManager: ObservableObject {
//
//    typealias Config = SheetAction.Info
//
//    enum SheetAction {
//
//        struct Info {
//            let systemName: String
//            let title: String
//            let content: String
//        }
//
//        case notAvailable
//        case present(info: Info)
//        case dismiss
//    }
//
//    @Published private(set) var action: SheetAction = .notAvailable
//
//    func present(with config: Config) {
//        // guard to see if already presented so don't present twice
//        guard !action.isPresented else { return }
//        self.action = .present(info: config)
//    }
//
//    func dismiss() {
//        self.action = .dismiss
//    }
//
//}
//
//extension SheetManager.SheetAction {
//    // Tells if presented instead of using == on each case. Computed value.
//    var isPresented: Bool {
//        guard case.present(_) = self else { return false }
//        return true
//
//    }
//}

