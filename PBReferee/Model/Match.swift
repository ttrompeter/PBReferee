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
    @Persisted var courtNumber = "1"
    @Persisted var currentGameArrayIndex = 0
    @Persisted var currentGameNumber = 1
    @Persisted var emailAddressForScoresheetSnaphot = ""
    @Persisted var eventTitle = "Fun Games At Oceana"
    @Persisted var firstServerDesignationGame1Team1 = "?"
    @Persisted var firstServerDesignationGame2Team1 = "?"
    @Persisted var firstServerDesignationGame3Team1 = "?"
    @Persisted var firstServerDesignationGame4Team1 = "?"
    @Persisted var firstServerDesignationGame5Team1 = "?"
    @Persisted var firstServerDesignationGame1Team2 = "?"
    @Persisted var firstServerDesignationGame2Team2 = "?"
    @Persisted var firstServerDesignationGame3Team2 = "?"
    @Persisted var firstServerDesignationGame4Team2 = "?"
    @Persisted var firstServerDesignationGame5Team2 = "?"
    @Persisted var isMatchCompleted = false
    @Persisted var matchDate = Date.now
    @Persisted var matchDuration = 0.0
    @Persisted var matchEndDateValue = Date.now
    @Persisted var matchFinalScore = "N/A"
    @Persisted var matchLocation = "Carol's Court"
    @Persisted var matchLoser = ""
    @Persisted var matchNotes = "Water breaks every 30 minutes"
    @Persisted var matchNumber = "13"
    @Persisted var matchRefereeRemarks = ""
    @Persisted var matchStartDateValue = Date.now
    @Persisted var matchStartingServerName = "Adam Rocafeller"    // Should be Undetermined
    @Persisted var matchStartingServerNumber = 1     // Should be 0
    @Persisted var matchWinner = ""
    @Persisted var matchWinningTeam = 0
    @Persisted var namePlayer1Team1 = "Adam Rocafeller"
    @Persisted var namePlayer2Team1 = "Judith Van Hammersmith"
    @Persisted var namePlayer1Team2 = "Alexandra Beckwith"
    @Persisted var namePlayer2Team2 = "Joseph Morikawa"
    @Persisted var numberOfTimeoutsPerGame = 2
    @Persisted var player1Team1Identifiers = "Red Hat"
    @Persisted var player2Team1Identifiers = "Blonde"
    @Persisted var player1Team2Identifiers = "Green Shirt"
    @Persisted var player2Team2Identifiers = "Yellow Shoes"
    @Persisted var scoreDisplay = "0 - 0 - 2"
    @Persisted var selectedDoublesPlay = 2
    @Persisted var selectedGameFormat = 7
    @Persisted var selectedMatchFormat = 1     //Should be 2 as default
    @Persisted var selectedScoringFormat = 1
    @Persisted var servingPlayerNumber = 1           // Should be 0
    @Persisted var specialTeam1 = "SpecialTm1"
    @Persisted var specialTeam2 = "SpecialTm2"
    @Persisted var teamTakingTimeout = 0
    @Persisted var whoIsServingText = "2nd Server"
    
    @Persisted var games = RealmSwift.List<Game>()
    
    
    var matchTotalPointsWinningTeam: Int {
        var matchTotalPoints = 0
        if isMatchCompleted {
            switch matchWinningTeam {
            case 1:
                matchTotalPoints = games[0].player1Points + games[0].player2Points + games[1].player1Points + games[1].player2Points + games[2].player1Points + games[2].player2Points + games[3].player1Points + games[3].player2Points + games[4].player1Points + games[4].player2Points
            case 2:
                matchTotalPoints = games[0].player3Points + games[0].player4Points + games[1].player3Points + games[1].player4Points + games[2].player3Points + games[2].player4Points + games[3].player3Points + games[3].player4Points + games[4].player3Points + games[4].player4Points
            default:
                print("Error calculating matchTotalPointsWinningTeam")
            }
        } else {
            //print("isMatchCompleted is false in computed property matchTotalPointsWinningTeam in MatchView")
        }
        return matchTotalPoints
    }
    
    var matchTotalPointsLosingTeam: Int {
        var matchTotalPoints = 0
        if isMatchCompleted {
            switch matchWinningTeam {
            case 1:
                matchTotalPoints = games[0].player3Points + games[0].player4Points + games[1].player3Points + games[1].player4Points + games[2].player3Points + games[2].player4Points + games[3].player3Points + games[3].player4Points + games[4].player3Points + games[4].player4Points
            case 2:
                matchTotalPoints = games[0].player1Points + games[0].player2Points + games[1].player1Points + games[1].player2Points + games[2].player1Points + games[2].player2Points + games[3].player1Points + games[3].player2Points + games[4].player1Points + games[4].player2Points
            default:
                print("Error calculating matchTotalPointsLosgTeam")
            }
        } else {
            print("isMatchCompleted is false in matrchTotalPointsLosingTeam")
        }
        
        return matchTotalPoints
    }
    
    var matchComputedDuration: Double {
        if isMatchCompleted {
            print("match start: \(matchStartDateValue),   match end: \(matchEndDateValue)")
            let matchDurationSeconds = matchStartDateValue.distance(to: matchEndDateValue)
            return (matchDurationSeconds / 60)
        } else {
            print("isMatchCompleted is false in matchComputedDuration so can't provide useful result.")
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
        switch selectedGameFormat {
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
    
    
    
 //===============================================================================
    
    // Blank image for server listing boxes
    @Persisted var serverFullBoxImage = Constants.BOX
    @Persisted var serverMiddleBoxImage = Constants.BOX_RIGHT_ONLY_END
    
    // Images for game 1 Team 1 points boxes - default values
    @Persisted var point1Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point2Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point3Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point4Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point5Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point6Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point7Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point8Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point9Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point10Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point11Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point12Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point13Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point14Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point15Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point16Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point17Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point18Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point19Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point20Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var point21Game1ImageTm1 = Constants.BOX_RIGHT_END
    
    // Images for game 2 Team 1 points boxes - default values
    @Persisted var point1Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point2Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point3Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point4Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point5Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point6Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point7Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point8Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point9Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point10Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point11Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point12Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point13Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point14Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point15Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point16Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point17Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point18Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point19Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point20Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var point21Game2ImageTm1 = Constants.BOX_RIGHT_END
    
    // Images for game 3 Team 1 points boxes - default values
    @Persisted var point1Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point2Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point3Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point4Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point5Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point6Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point7Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point8Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point9Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point10Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point11Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point12Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point13Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point14Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point15Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point16Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point17Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point18Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point19Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point20Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point21Game3ImageTm1 = Constants.BOX
    
    // Images for game 4 Team 1 points boxes - default values
    @Persisted var point1Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point2Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point3Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point4Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point5Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point6Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point7Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point8Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point9Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point10Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point11Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point12Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point13Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point14Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point15Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point16Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point17Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point18Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point19Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point20Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var point21Game4ImageTm1 = Constants.BOX_RIGHT_ONLY_END
    
    // Images for game 5 Team 1 points boxes - default values
    @Persisted var point1Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point2Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point3Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point4Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point5Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point6Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point7Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point8Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point9Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point10Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point11Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point12Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point13Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point14Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point15Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point16Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point17Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point18Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point19Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point20Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point21Game5ImageTm1 = Constants.BOX
    
    // Images for game 1 Team 2 points boxes - default values
    @Persisted var point1Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point2Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point3Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point4Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point5Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point6Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point7Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point8Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point9Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point10Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point11Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point12Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point13Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point14Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point15Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point16Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point17Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point18Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point19Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point20Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var point21Game1ImageTm2 = Constants.BOX_RIGHT_END
    
    // Images for game 2 Team 2 points boxes - default values
    @Persisted var point1Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point2Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point3Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point4Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point5Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point6Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point7Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point8Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point9Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point10Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point11Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point12Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point13Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point14Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point15Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point16Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point17Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point18Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point19Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point20Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var point21Game2ImageTm2 = Constants.BOX_RIGHT_END
    
    // Images for game 3 Team 2 points boxes - default values
    @Persisted var point1Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point2Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point3Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point4Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point5Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point6Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point7Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point8Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point9Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point10Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point11Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point12Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point13Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point14Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point15Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point16Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point17Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point18Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point19Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point20Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point21Game3ImageTm2 = Constants.BOX
    
    // Images for game 4 Team 2 points boxes - default values
    @Persisted var point1Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point2Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point3Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point4Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point5Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point6Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point7Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point8Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point9Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point10Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point11Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point12Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point13Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point14Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point15Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point16Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point17Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point18Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point19Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point20Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var point21Game4ImageTm2 = Constants.BOX_RIGHT_ONLY_END
    
    // Images for game 5 Team 2 points boxes - default values
    @Persisted var point1Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point2Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point3Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point4Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point5Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point6Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point7Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point8Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point9Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point10Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point11Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point12Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point13Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point14Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point15Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point16Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point17Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point18Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point19Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point20Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var point21Game5ImageTm2 = Constants.BOX
    
    
    // Images for timeout boxes - default values
    @Persisted var timeOut1Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var timeOut2Game1ImageTm1 = Constants.BOX_RIGHT_END
    @Persisted var timeOut2_5Game1ImageTm1 = Constants.BOX_LEFT
    @Persisted var timeOut3Game1ImageTm1 = Constants.BOX_RIGHT_END
    
    @Persisted var timeOut1Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var timeOut2Game2ImageTm1 = Constants.BOX_RIGHT_END
    @Persisted var timeOut2_5Game2ImageTm1 = Constants.BOX_LEFT
    @Persisted var timeOut3Game2ImageTm1 = Constants.BOX_RIGHT_END
    
    @Persisted var timeOut1Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var timeOut2Game3ImageTm1 = Constants.BOX
    @Persisted var timeOut2_5Game3ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var timeOut3Game3ImageTm1 = Constants.BOX
    
    @Persisted var timeOut1Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var timeOut2Game4ImageTm1 = Constants.BOX_LEFT_ONLY
    @Persisted var timeOut3Game4ImageTm1 = Constants.BOX_RIGHT_ONLY_END
    @Persisted var timeOut1Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var timeOut2Game5ImageTm1 = Constants.BOX_BOTTOM_LEFT
    @Persisted var timeOut3Game5ImageTm1 = Constants.BOX
    
    @Persisted var timeOut1Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var timeOut2Game1ImageTm2 = Constants.BOX_RIGHT_END
    @Persisted var timeOut2_5Game1ImageTm2 = Constants.BOX_LEFT
    @Persisted var timeOut3Game1ImageTm2 = Constants.BOX_RIGHT_END
    
    @Persisted var timeOut1Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var timeOut2Game2ImageTm2 = Constants.BOX_RIGHT_END
    @Persisted var timeOut2_5Game2ImageTm2 = Constants.BOX_LEFT
    @Persisted var timeOut3Game2ImageTm2 = Constants.BOX_RIGHT_END
    
    @Persisted var timeOut1Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var timeOut2Game3ImageTm2 = Constants.BOX
    @Persisted var timeOut2_5Game3ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var timeOut3Game3ImageTm2 = Constants.BOX
    
    @Persisted var timeOut1Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var timeOut2Game4ImageTm2 = Constants.BOX_LEFT_ONLY
    @Persisted var timeOut3Game4ImageTm2 = Constants.BOX_RIGHT_ONLY_END
    @Persisted var timeOut1Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var timeOut2Game5ImageTm2 = Constants.BOX_BOTTOM_LEFT
    @Persisted var timeOut3Game5ImageTm2 = Constants.BOX
    
    
    // Images for sideouts Team1 Game 1
    @Persisted var isSideoutPoint0Game1Team1 = false
    @Persisted var isSideoutPoint1Game1Team1 = false
    @Persisted var isSideoutPoint2Game1Team1 = false
    @Persisted var isSideoutPoint3Game1Team1 = false
    @Persisted var isSideoutPoint4Game1Team1 = false
    @Persisted var isSideoutPoint5Game1Team1 = false
    @Persisted var isSideoutPoint6Game1Team1 = false
    @Persisted var isSideoutPoint7Game1Team1 = false
    @Persisted var isSideoutPoint8Game1Team1 = false
    @Persisted var isSideoutPoint9Game1Team1 = false
    @Persisted var isSideoutPoint10Game1Team1 = false
    @Persisted var isSideoutPoint11Game1Team1 = false
    @Persisted var isSideoutPoint12Game1Team1 = false
    @Persisted var isSideoutPoint13Game1Team1 = false
    @Persisted var isSideoutPoint14Game1Team1 = false
    @Persisted var isSideoutPoint15Game1Team1 = false
    @Persisted var isSideoutPoint16Game1Team1 = false
    @Persisted var isSideoutPoint17Game1Team1 = false
    @Persisted var isSideoutPoint18Game1Team1 = false
    @Persisted var isSideoutPoint19Game1Team1 = false
    @Persisted var isSideoutPoint20Game1Team1 = false
    @Persisted var isSideoutPoint21Game1Team1 = false
    
    // Images for sideouts Team1 Game 2
    @Persisted var isSideoutPoint0Game2Team1 = false
    @Persisted var isSideoutPoint1Game2Team1 = false
    @Persisted var isSideoutPoint2Game2Team1 = false
    @Persisted var isSideoutPoint3Game2Team1 = false
    @Persisted var isSideoutPoint4Game2Team1 = false
    @Persisted var isSideoutPoint5Game2Team1 = false
    @Persisted var isSideoutPoint6Game2Team1 = false
    @Persisted var isSideoutPoint7Game2Team1 = false
    @Persisted var isSideoutPoint8Game2Team1 = false
    @Persisted var isSideoutPoint9Game2Team1 = false
    @Persisted var isSideoutPoint10Game2Team1 = false
    @Persisted var isSideoutPoint11Game2Team1 = false
    @Persisted var isSideoutPoint12Game2Team1 = false
    @Persisted var isSideoutPoint13Game2Team1 = false
    @Persisted var isSideoutPoint14Game2Team1 = false
    @Persisted var isSideoutPoint15Game2Team1 = false
    @Persisted var isSideoutPoint16Game2Team1 = false
    @Persisted var isSideoutPoint17Game2Team1 = false
    @Persisted var isSideoutPoint18Game2Team1 = false
    @Persisted var isSideoutPoint19Game2Team1 = false
    @Persisted var isSideoutPoint20Game2Team1 = false
    @Persisted var isSideoutPoint21Game2Team1 = false
    
    // Images for sideouts Team1 Game 3
    @Persisted var isSideoutPoint0Game3Team1 = false
    @Persisted var isSideoutPoint1Game3Team1 = false
    @Persisted var isSideoutPoint2Game3Team1 = false
    @Persisted var isSideoutPoint3Game3Team1 = false
    @Persisted var isSideoutPoint4Game3Team1 = false
    @Persisted var isSideoutPoint5Game3Team1 = false
    @Persisted var isSideoutPoint6Game3Team1 = false
    @Persisted var isSideoutPoint7Game3Team1 = false
    @Persisted var isSideoutPoint8Game3Team1 = false
    @Persisted var isSideoutPoint9Game3Team1 = false
    @Persisted var isSideoutPoint10Game3Team1 = false
    @Persisted var isSideoutPoint11Game3Team1 = false
    @Persisted var isSideoutPoint12Game3Team1 = false
    @Persisted var isSideoutPoint13Game3Team1 = false
    @Persisted var isSideoutPoint14Game3Team1 = false
    @Persisted var isSideoutPoint15Game3Team1 = false
    @Persisted var isSideoutPoint16Game3Team1 = false
    @Persisted var isSideoutPoint17Game3Team1 = false
    @Persisted var isSideoutPoint18Game3Team1 = false
    @Persisted var isSideoutPoint19Game3Team1 = false
    @Persisted var isSideoutPoint20Game3Team1 = false
    @Persisted var isSideoutPoint21Game3Team1 = false
    
    // Images for sideouts Team1 Game 4
    @Persisted var isSideoutPoint0Game4Team1 = false
    @Persisted var isSideoutPoint1Game4Team1 = false
    @Persisted var isSideoutPoint2Game4Team1 = false
    @Persisted var isSideoutPoint3Game4Team1 = false
    @Persisted var isSideoutPoint4Game4Team1 = false
    @Persisted var isSideoutPoint5Game4Team1 = false
    @Persisted var isSideoutPoint6Game4Team1 = false
    @Persisted var isSideoutPoint7Game4Team1 = false
    @Persisted var isSideoutPoint8Game4Team1 = false
    @Persisted var isSideoutPoint9Game4Team1 = false
    @Persisted var isSideoutPoint10Game4Team1 = false
    @Persisted var isSideoutPoint11Game4Team1 = false
    @Persisted var isSideoutPoint12Game4Team1 = false
    @Persisted var isSideoutPoint13Game4Team1 = false
    @Persisted var isSideoutPoint14Game4Team1 = false
    @Persisted var isSideoutPoint15Game4Team1 = false
    @Persisted var isSideoutPoint16Game4Team1 = false
    @Persisted var isSideoutPoint17Game4Team1 = false
    @Persisted var isSideoutPoint18Game4Team1 = false
    @Persisted var isSideoutPoint19Game4Team1 = false
    @Persisted var isSideoutPoint20Game4Team1 = false
    @Persisted var isSideoutPoint21Game4Team1 = false
    
    // Images for sideouts Team1 Game 5
    @Persisted var isSideoutPoint0Game5Team1 = false
    @Persisted var isSideoutPoint1Game5Team1 = false
    @Persisted var isSideoutPoint2Game5Team1 = false
    @Persisted var isSideoutPoint3Game5Team1 = false
    @Persisted var isSideoutPoint4Game5Team1 = false
    @Persisted var isSideoutPoint5Game5Team1 = false
    @Persisted var isSideoutPoint6Game5Team1 = false
    @Persisted var isSideoutPoint7Game5Team1 = false
    @Persisted var isSideoutPoint8Game5Team1 = false
    @Persisted var isSideoutPoint9Game5Team1 = false
    @Persisted var isSideoutPoint10Game5Team1 = false
    @Persisted var isSideoutPoint11Game5Team1 = false
    @Persisted var isSideoutPoint12Game5Team1 = false
    @Persisted var isSideoutPoint13Game5Team1 = false
    @Persisted var isSideoutPoint14Game5Team1 = false
    @Persisted var isSideoutPoint15Game5Team1 = false
    @Persisted var isSideoutPoint16Game5Team1 = false
    @Persisted var isSideoutPoint17Game5Team1 = false
    @Persisted var isSideoutPoint18Game5Team1 = false
    @Persisted var isSideoutPoint19Game5Team1 = false
    @Persisted var isSideoutPoint20Game5Team1 = false
    @Persisted var isSideoutPoint21Game5Team1 = false
    
    // Images for sideouts Team 2 Game 1
    @Persisted var isSideoutPoint0Game1Team2 = false
    @Persisted var isSideoutPoint1Game1Team2 = false
    @Persisted var isSideoutPoint2Game1Team2 = false
    @Persisted var isSideoutPoint3Game1Team2 = false
    @Persisted var isSideoutPoint4Game1Team2 = false
    @Persisted var isSideoutPoint5Game1Team2 = false
    @Persisted var isSideoutPoint6Game1Team2 = false
    @Persisted var isSideoutPoint7Game1Team2 = false
    @Persisted var isSideoutPoint8Game1Team2 = false
    @Persisted var isSideoutPoint9Game1Team2 = false
    @Persisted var isSideoutPoint10Game1Team2 = false
    @Persisted var isSideoutPoint11Game1Team2 = false
    @Persisted var isSideoutPoint12Game1Team2 = false
    @Persisted var isSideoutPoint13Game1Team2 = false
    @Persisted var isSideoutPoint14Game1Team2 = false
    @Persisted var isSideoutPoint15Game1Team2 = false
    @Persisted var isSideoutPoint16Game1Team2 = false
    @Persisted var isSideoutPoint17Game1Team2 = false
    @Persisted var isSideoutPoint18Game1Team2 = false
    @Persisted var isSideoutPoint19Game1Team2 = false
    @Persisted var isSideoutPoint20Game1Team2 = false
    @Persisted var isSideoutPoint21Game1Team2 = false
    
    // Images for sideouts Team 2 Game 2
    @Persisted var isSideoutPoint0Game2Team2 = false
    @Persisted var isSideoutPoint1Game2Team2 = false
    @Persisted var isSideoutPoint2Game2Team2 = false
    @Persisted var isSideoutPoint3Game2Team2 = false
    @Persisted var isSideoutPoint4Game2Team2 = false
    @Persisted var isSideoutPoint5Game2Team2 = false
    @Persisted var isSideoutPoint6Game2Team2 = false
    @Persisted var isSideoutPoint7Game2Team2 = false
    @Persisted var isSideoutPoint8Game2Team2 = false
    @Persisted var isSideoutPoint9Game2Team2 = false
    @Persisted var isSideoutPoint10Game2Team2 = false
    @Persisted var isSideoutPoint11Game2Team2 = false
    @Persisted var isSideoutPoint12Game2Team2 = false
    @Persisted var isSideoutPoint13Game2Team2 = false
    @Persisted var isSideoutPoint14Game2Team2 = false
    @Persisted var isSideoutPoint15Game2Team2 = false
    @Persisted var isSideoutPoint16Game2Team2 = false
    @Persisted var isSideoutPoint17Game2Team2 = false
    @Persisted var isSideoutPoint18Game2Team2 = false
    @Persisted var isSideoutPoint19Game2Team2 = false
    @Persisted var isSideoutPoint20Game2Team2 = false
    @Persisted var isSideoutPoint21Game2Team2 = false
    
    // Images for sideouts Team 2 Game 3
    @Persisted var isSideoutPoint0Game3Team2 = false
    @Persisted var isSideoutPoint1Game3Team2 = false
    @Persisted var isSideoutPoint2Game3Team2 = false
    @Persisted var isSideoutPoint3Game3Team2 = false
    @Persisted var isSideoutPoint4Game3Team2 = false
    @Persisted var isSideoutPoint5Game3Team2 = false
    @Persisted var isSideoutPoint6Game3Team2 = false
    @Persisted var isSideoutPoint7Game3Team2 = false
    @Persisted var isSideoutPoint8Game3Team2 = false
    @Persisted var isSideoutPoint9Game3Team2 = false
    @Persisted var isSideoutPoint10Game3Team2 = false
    @Persisted var isSideoutPoint11Game3Team2 = false
    @Persisted var isSideoutPoint12Game3Team2 = false
    @Persisted var isSideoutPoint13Game3Team2 = false
    @Persisted var isSideoutPoint14Game3Team2 = false
    @Persisted var isSideoutPoint15Game3Team2 = false
    @Persisted var isSideoutPoint16Game3Team2 = false
    @Persisted var isSideoutPoint17Game3Team2 = false
    @Persisted var isSideoutPoint18Game3Team2 = false
    @Persisted var isSideoutPoint19Game3Team2 = false
    @Persisted var isSideoutPoint20Game3Team2 = false
    @Persisted var isSideoutPoint21Game3Team2 = false
    
    // Images for sideouts Team 2 Game 4
    @Persisted var isSideoutPoint0Game4Team2 = false
    @Persisted var isSideoutPoint1Game4Team2 = false
    @Persisted var isSideoutPoint2Game4Team2 = false
    @Persisted var isSideoutPoint3Game4Team2 = false
    @Persisted var isSideoutPoint4Game4Team2 = false
    @Persisted var isSideoutPoint5Game4Team2 = false
    @Persisted var isSideoutPoint6Game4Team2 = false
    @Persisted var isSideoutPoint7Game4Team2 = false
    @Persisted var isSideoutPoint8Game4Team2 = false
    @Persisted var isSideoutPoint9Game4Team2 = false
    @Persisted var isSideoutPoint10Game4Team2 = false
    @Persisted var isSideoutPoint11Game4Team2 = false
    @Persisted var isSideoutPoint12Game4Team2 = false
    @Persisted var isSideoutPoint13Game4Team2 = false
    @Persisted var isSideoutPoint14Game4Team2 = false
    @Persisted var isSideoutPoint15Game4Team2 = false
    @Persisted var isSideoutPoint16Game4Team2 = false
    @Persisted var isSideoutPoint17Game4Team2 = false
    @Persisted var isSideoutPoint18Game4Team2 = false
    @Persisted var isSideoutPoint19Game4Team2 = false
    @Persisted var isSideoutPoint20Game4Team2 = false
    @Persisted var isSideoutPoint21Game4Team2 = false
    
    // Images for sideouts Team 2 Game 5
    @Persisted var isSideoutPoint0Game5Team2 = false
    @Persisted var isSideoutPoint1Game5Team2 = false
    @Persisted var isSideoutPoint2Game5Team2 = false
    @Persisted var isSideoutPoint3Game5Team2 = false
    @Persisted var isSideoutPoint4Game5Team2 = false
    @Persisted var isSideoutPoint5Game5Team2 = false
    @Persisted var isSideoutPoint6Game5Team2 = false
    @Persisted var isSideoutPoint7Game5Team2 = false
    @Persisted var isSideoutPoint8Game5Team2 = false
    @Persisted var isSideoutPoint9Game5Team2 = false
    @Persisted var isSideoutPoint10Game5Team2 = false
    @Persisted var isSideoutPoint11Game5Team2 = false
    @Persisted var isSideoutPoint12Game5Team2 = false
    @Persisted var isSideoutPoint13Game5Team2 = false
    @Persisted var isSideoutPoint14Game5Team2 = false
    @Persisted var isSideoutPoint15Game5Team2 = false
    @Persisted var isSideoutPoint16Game5Team2 = false
    @Persisted var isSideoutPoint17Game5Team2 = false
    @Persisted var isSideoutPoint18Game5Team2 = false
    @Persisted var isSideoutPoint19Game5Team2 = false
    @Persisted var isSideoutPoint20Game5Team2 = false
    @Persisted var isSideoutPoint21Game5Team2 = false
    
    
}




