//
//  Match.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

class Match: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var courtNumber = ""
    @Persisted var currentGameArrayIndex = 0
    @Persisted var currentGameNumber = 1
    @Persisted var emailAddressForScoresheetSnaphot = ""
    @Persisted var emailAddressForUser = ""
    @Persisted var eventTitle = ""
    @Persisted var firstServerDesignationGame1Team1 = ""
    @Persisted var firstServerDesignationGame2Team1 = ""
    @Persisted var firstServerDesignationGame3Team1 = ""
    @Persisted var firstServerDesignationGame4Team1 = ""
    @Persisted var firstServerDesignationGame5Team1 = ""
    @Persisted var firstServerDesignationGame1Team2 = ""
    @Persisted var firstServerDesignationGame2Team2 = ""
    @Persisted var firstServerDesignationGame3Team2 = ""
    @Persisted var firstServerDesignationGame4Team2 = ""
    @Persisted var firstServerDesignationGame5Team2 = ""
    @Persisted var isCompleted = false
    @Persisted var isForfeitMatch = false
    @Persisted var isMatchSetupCompleted = false
    @Persisted var isMatchStarted = false
    @Persisted var isSecondServer = true
    @Persisted var isServerSideSet = false
    @Persisted var isServingLeftSide = false
    @Persisted var isTeam1Serving = true
    @Persisted var isShowViolation1Tm1 = false
    @Persisted var isShowViolation2Tm1 = false
    @Persisted var isShowViolation3Tm1 = false
    @Persisted var isShowViolation1Tm2 = false
    @Persisted var isShowViolation2Tm2 = false
    @Persisted var isShowViolation3Tm2 = false
    @Persisted var matchDate = Date.now
    @Persisted var matchDuration = 0.0
    @Persisted var matchEndDateValue = Date.now
    @Persisted var matchFinalGameScores = ""
    @Persisted var matchFinalScore = ""
    @Persisted var matchLocation = ""
    @Persisted var matchLoser = ""
    @Persisted var matchNotes = ""
    @Persisted var matchNumber = ""
    @Persisted var matchRefereeRemarks = ""
    @Persisted var matchStartDateValue = Date.now
    @Persisted var matchStartingServerName = ""
    @Persisted var matchStartingServerNumber = 0
    @Persisted var matchWinner = ""
    @Persisted var matchWinningTeam = 0
    @Persisted var namePlayer1Team1 = ""
    @Persisted var namePlayer2Team1 = ""
    @Persisted var namePlayer1Team2 = ""
    @Persisted var namePlayer2Team2 = ""
    @Persisted var numberOfTimeoutsPerGame = 2
    @Persisted var player1Team1Identifiers = ""
    @Persisted var player2Team1Identifiers = ""
    @Persisted var player1Team2Identifiers = ""
    @Persisted var player2Team2Identifiers = ""
    @Persisted var scoreDisplay = "0 - 0 - 2"
    // Play Style (selectedDoublesPlay) Options: 1 - Singles, 2 - Doubles
    @Persisted var selectedDoublesPlay = 2
    // Match Format Options: 1 - Single Game, 2 - 2 of 3 Games, 3 - 3 of 5 Games
    @Persisted var selectedMatchFormat = 2
    // PointsToWin Options: 7 Points, 11 Points, 15 Points, 21 Points
    @Persisted var selectedPointsToWin = 11
    // Scoring Format Options 1 - Regular Scoring, 2 - Rally Scoring
    @Persisted var selectedScoringFormat = 1
    @Persisted var servingPlayerNumber = 0
    @Persisted var specialTeam1 = ""
    @Persisted var specialTeam2 = ""
    @Persisted var teamTakingTimeout = 0
    @Persisted var whoIsServingText = "2nd Server"
    
    @Persisted var games = RealmSwift.List<Game>()
    @Persisted var images = RealmSwift.List<ScoringImages>()
    @Persisted var points = RealmSwift.List<PointImage>()
    @Persisted var timeouts = RealmSwift.List<TimeOutImage>()
    @Persisted var violations = RealmSwift.List<Violation>()
    
    
    var matchTotalPointsWinningTeam: Int {
        var matchTotalPoints = 0
        if isCompleted {
            switch matchWinningTeam {
            case 1:
                matchTotalPoints = games[0].player1Points + games[0].player2Points + games[1].player1Points + games[1].player2Points + games[2].player1Points + games[2].player2Points + games[3].player1Points + games[3].player2Points + games[4].player1Points + games[4].player2Points
            case 2:
                matchTotalPoints = games[0].player3Points + games[0].player4Points + games[1].player3Points + games[1].player4Points + games[2].player3Points + games[2].player4Points + games[3].player3Points + games[3].player4Points + games[4].player3Points + games[4].player4Points
            default:
                print("Error calculating matchTotalPointsWinningTeam")
            }
        } else {
            //print("isCompleted is false in computed property matchTotalPointsWinningTeam in Match object")
        }
        return matchTotalPoints
    }
    
    var matchTotalPointsLosingTeam: Int {
        var matchTotalPoints = 0
        if isCompleted {
            switch matchWinningTeam {
            case 1:
                matchTotalPoints = games[0].player3Points + games[0].player4Points + games[1].player3Points + games[1].player4Points + games[2].player3Points + games[2].player4Points + games[3].player3Points + games[3].player4Points + games[4].player3Points + games[4].player4Points
            case 2:
                matchTotalPoints = games[0].player1Points + games[0].player2Points + games[1].player1Points + games[1].player2Points + games[2].player1Points + games[2].player2Points + games[3].player1Points + games[3].player2Points + games[4].player1Points + games[4].player2Points
            default:
                print("Error calculating matchTotalPointsLosgTeam")
            }
        } else {
            print("isCompleted is false in computed property matchTotalPointsLosingTeam in Match object")
        }
        
        return matchTotalPoints
    }
    
    var matchComputedDuration: Double {
        if isCompleted {
            let matchDurationSeconds = matchStartDateValue.distance(to: matchEndDateValue)
            return (matchDurationSeconds / 60)
        } else {
            print("isCompleted is false in matchComputedDuration so can't provide useful result.")
            return 0.0
        }
        
    }
    
    var player1FirstName: String {
        var firstName = ""
        let fullName = namePlayer1Team1
        var components = fullName.components(separatedBy: " ")
        if components.count > 0 {
            firstName = components.removeFirst()
        } else {
            print("Error determining playerFirstName in Match object.")
        }
        return firstName
    }
    
    var player2FirstName: String {
        var firstName = ""
        let fullName = namePlayer2Team1
        var components = fullName.components(separatedBy: " ")
        if components.count > 0 {
            firstName = components.removeFirst()
            //let lastName = components.joined(separator: " ")
        } else {
            firstName = fullName
        }
        return firstName
    }
    
    var player3FirstName: String {
        var firstName = ""
        let fullName = namePlayer1Team2
        var components = fullName.components(separatedBy: " ")
        if components.count > 0 {
            firstName = components.removeFirst()
            //let lastName = components.joined(separator: " ")
        } else {
            firstName = fullName
        }
        return firstName
    }
    
    var player4FirstName: String {
        var firstName = ""
        let fullName = namePlayer2Team2
        var components = fullName.components(separatedBy: " ")
        if components.count > 0 {
            firstName = components.removeFirst()
            //let lastName = components.joined(separator: " ")
        } else {
            firstName = fullName
        }
        return firstName
    }
    
    var matchFormatDescription: String {
        switch selectedMatchFormat {
        case 1:
            return "Single game"
        case 2:
            return "Best 2 out of 3 games"
        case 3:
            return "Best 3 out of 5 games"
        default:
            print("Error selecting matchFormatDescription.")
            return "Unknown Match Format"
        }
    }
    
    var gameFormatDescription: String {
        switch selectedPointsToWin {
        case 7:
            return "7 points, win by 2 points"
        case 11:
            return "11 points, win by 2 points"
        case 15:
            return "15 points, win by 2 points"
        case 21:
            return "21 points, win by 2 points"
        default:
            print("Error selecting gameFormatDescription.")
            return "Unknown Game Format"
        }
    }
    
    var matchStyleDescription: String {
        switch selectedDoublesPlay {
        case 1:
            return "Doubles"
        case 2:
            return "Singles"
        default:
            print("Error selecting gameFormatDescription.")
            return "Unknown"
        }
    }
    
    var matchScoringFormatDescription: String {
        switch selectedScoringFormat {
        case 1:
            return "Regular Scoring"
        case 2:
            return "Rally Scoring"
        default:
            print("Error selecting gameFormatDescription.")
            return "Unknown Scoring"
        }
    }
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
}




