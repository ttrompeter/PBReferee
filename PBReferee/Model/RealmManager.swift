//
//  RealmManager.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/30/22.
//

import Foundation
import RealmSwift
import SwiftUI
import UIKit

class RealmManager: ObservableObject {
    
    private(set) var realm: Realm?
    @Published var matches: Results<Match>?
    @Published var violations: Results<Violation>?
    @Published var searchFilter = ""
    
    private var matchesToken: NotificationToken?
    
    var matchesArray: [Match] {
        if let matches = matches {
            print("matches count in matchesArray of RealmManager \(matches.count)")
            // Convert Results to an array
            return Array(matches)
        } else {
            return []
        }
    }
    
    var searchResults: [Match] {
        if searchFilter.isEmpty {
            return matchesArray
        } else {
            return matchesArray.filter { $0.eventTitle.lowercased().contains(searchFilter.lowercased()) }
        }
    }
    
    // TODO: - This is just seed data for development - delete in production
    let EventNamesArray = ["Solana Beach Summer Games","Jamul Pickleball Jamboree","Monterey Seniors Tournament","Pickleball In Pasadena","San Jose Regionals","Mountain View Invitational Tournament","San Francisco By The Bay Open Championship","Vancouver Friendly Round Robin","Victorville Regional Fun Games","Yuma Winter Festival GAmes","Las Vegas Seniors Open Championship","Portland Western Open Games","Salt Lake City Tournament","Reno City Championship","Huntington Beach Regional Tournament","Santa Maria Round  Robin Matches","Twentynine Palms Hot Games","Thousand Oaks Senior Championship","San Dismas Pickleball Round Robin","Sausalito Fun Games","Solvang Danish Open","Venice All-Ages Championships","Vista Senior Players Championship","Temecula Pickleball Matches","Santa Clarita Regional Open Games","Swami's Pickleball Round Robin Matches","Santa Barbara Regional Championship","Melba Bishop Fun Games","Big Sur West Coast Championship","Big Bear Lake Open Championship","Carmel-By-The-Sea Pickleball Championship","Coronado Senior Fun Games","Del Mar Round Robin Games","Fish Camp Senior Open Championship","Half Moon Bay Pickleball Invitational","Hermosa Beach All-Ages Invitational","Julian Pickleball Jamboree","Lost Hills Regional Open","Manhattan Beach Junior Championships","Milpitas Memorial Open","Nipton World Invitational","Ojai Pickleball Championships","Port Hueneme Pickleball Open Championships","Petaluma Pickleball Fun Games","Rancho Palos Verdes Pickleball Masters Tournament"]
    
    let PlayerNamesArray = ["Abigal Adams", "Samuel Chase", "John Jay", "Harriet Stowe", "Thomas Johnson", "William Rhenquist", "James Iredall", "Elizabeth Stanton", "John Rutledge", "Benjamin Curtis", "Oliver Ellsworth", "Susan Anthony", "William Cushing", "Bushrod Washington", "John Archibald", "James Wilson", "John Blair", "Antonin Scalia", "William Paterson", "Alfred Moore", "Harriet Tubman", "John Marshall", "William Johnson", "Henry Livingston", "Thomas Todd", "Gabriel Duvall", "Joseph Story", "Clara Barton", "Smith Thompson", "Robert Trimble", "Emily Dickinson", "Louisa Alcott", "Gail Laughlin", "Georgia O'Keeffe", "Margaret Smith", "Roger Taney", "John McLean", "Margaret Mead", "Henry Baldwin", "Mildred Zaharias", "James Wayne", "Jane Godall", "Phillip Barbour", "Barbara Jordan", "John Catron", "Mia Hamm", "John McKinley", "Chloe Kim", "Peter Daniel", "Kathrine Johnson", "Samuel Nelson", "Margaret Bourke-White", "Levi Woodbury", "Valentina Tereshkova", "Robert Grier", "Misty Copeland", "John Campbell", "Ester Ledecka", "Nathan Clifford", "Naomi Osaka", "Noah Swayne", "Ibtihaj Muhammad", "Samuel Miller", "Laverne Cox", "David Davis", "Shonda Rhimes", "Stephen Field", "Ariana Grande", "Mindy Kaling", "William Strong", "Marie Kondo", "Joseph Bradley", "Julie Taymor", "Ashley Graham", "Ruth Ginsburg", "Ward Hunt", "Morrison Waite", "John Harlan", "William Woods", "Stanley Mathews", "Horace Gray", "Hypatia Alexandria", "Elena Piscopia", "Samuel Blatchford", "Naria Agnesi", "Lucius Lamar", "Sophie Germain", "Melville Fuller", "Mary Sommerville", "Ada Lovelace", "David Brewer", "Charlotte Scott", "Henry Brown", "Sofia Kovalevskaya", "George Shiras", "Alicia Stott", "Howell Jackson", "Amalie Noether", "Edward White", "Mary Walker", "Rufus Peckham", "Edith Wharton", "Joseph McKenna", "Dorthy Levitt", "Oliver Holmes", "Sarah Breedlove", "William Day", "Jeannette Rankin", "William Moody", "Margaret Sanger", "Horace Lurton", "Jane Addams", "Charles Hughes", "Gwendolyn Brooks", "Edward White", "Elizabeth Eckford", "Willis Devanter", "Junko Tabei", "Joseph Lamar", "Sally Ride", "Mahlon Pitney", "Ann Dunwoody", "James McReynolds", "Mae Jamison", "John Clarke", "William Taft", "Frida Kahlo", "George Sutherland", "Rita Moreno", "Pierce Butler", "Maria Salinas", "Edward Sanford", "Demi Lovato", "Harlan Stone", "Dara Torres", "Charles Hughes", "Zhou Qunfei", "Owen Roberts", "Harlan Stone", "Hugo Black", "Stanley Reed", "Selena Quintanilla", "William Douglas", "Frank Murphy", "Francoise Meyers", "James Byrne", "Robert Jackson", "Maria Moraes", "Maria Fissolo", "Jacqueline Mars", "Wiley Rutledge", "Harold Burton", "Fred Vinson", "Tom Clark", "Sherman Minton"]
    
    let LocationArray = ["Carol's Court At Oceana", "Poinsetta Park Tennis & Pickleball Courts", "Pickleball Club of Carlsbad", "Bobby Riggs Racket & Paddle Center", "Melba Bishop Recreation Center", "Calavera Community Center", "Brengle Terrace Park", "St. Michaels By-the-Sea Pickleball", "Cottonwood Creek Park", "Carmel Valley Recreation Center", "Pacific Highlands Ranch", "Altamira 4 Tennis & Pickleball", "Ocean Air Recreational Center", "Pacific Beach Tennis Club", "Boogard's Pickleball Ranch", "Big Rock Park", "MackenzieCreek Park", "Cypress Canyon Park", "Del Cerro Tennis Club", "Colina Del Sol Park", "Pine Avenue Community Center", "Stagecoach Community Center", "Junior Seau Community Center", "Ocean Hills Country Club", "Thibodo Park", "Lomas Santa Fe Country Club", "Glassman Recreation Center", "Innovation Park", "Meadows Park", "French Park", "Barnes Tennis Center", "Ocean Beach Recreation Center", "Olive Grove Park"]
    
    init() {
        initializeSchema()
        setupObserver()
    }
    
    // TODO: - This is just for development - delete for production
    func addNewDevelopmentGames() {
        print("Starting addNewDevelopmentGames")
        // Create games and add to the existing Match
        if let realm = realm {
            do {
                let matchToUse = realm.objects(Match.self)[0]
                let settings = realm.objects(Settings.self)[0]
                try realm.write {
                    //print("matchToUse games.count before add: \(matchToUse.games.count)")
                    let game1 = Game()
                    game1.gameNumber = 1
                    game1.refereeName = settings.defaultRefereeName
                    game1.gameFirstServerPlayerNumber = 1               // Default is 0
                    game1.selectedFirstServerTeam1 = 1                  // Default is 0
                    game1.selectedFirstServerTeam2 = 4                  // Default is 0
                    game1.gameStartDateValue = Calendar.current.date(byAdding: .minute, value: -17, to: Date())!
                    matchToUse.games.append(game1)
                    let game2 = Game()
                    game2.gameNumber = 2
                    game2.refereeName = settings.defaultRefereeName
                    game2.gameFirstServerPlayerNumber = 1               // Default is 0
                    game2.selectedFirstServerTeam1 = 1                  // Default is 0
                    game2.selectedFirstServerTeam2 = 4                  // Default is 0
                    game2.gameStartDateValue = Calendar.current.date(byAdding: .minute, value: -17, to: Date())!
                    matchToUse.games.append(game2)
                    let game3 = Game()
                    game3.gameNumber = 3
                    game3.refereeName = settings.defaultRefereeName
                    game3.gameFirstServerPlayerNumber = 1               // Default is 0
                    game3.selectedFirstServerTeam1 = 1                  // Default is 0
                    game3.selectedFirstServerTeam2 = 4                  // Default is 0
                    game3.gameStartDateValue = Calendar.current.date(byAdding: .minute, value: -17, to: Date())!
                    matchToUse.games.append(game3)
                    let game4 = Game()
                    game4.gameNumber = 4
                    game4.refereeName = settings.defaultRefereeName
                    game4.gameFirstServerPlayerNumber = 1               // Default is 0
                    game4.selectedFirstServerTeam1 = 1                  // Default is 0
                    game4.selectedFirstServerTeam2 = 4                  // Default is 0
                    game4.gameStartDateValue = Calendar.current.date(byAdding: .minute, value: -17, to: Date())!
                    matchToUse.games.append(game4)
                    let game5 = Game()
                    game5.gameNumber = 5
                    game5.refereeName = settings.defaultRefereeName
                    game5.gameFirstServerPlayerNumber = 1               // Default is 0
                    game5.selectedFirstServerTeam1 = 1                  // Default is 0
                    game5.selectedFirstServerTeam2 = 4                  // Default is 0
                    game5.gameStartDateValue = Calendar.current.date(byAdding: .minute, value: -17, to: Date())!
                    matchToUse.games.append(game5)
                    //print("matchToUse games.count after add in addNewDevelopmentGames: \(matchToUse.games.count)")
                }
            } catch {
                print("Error adding games in Realm Manager")
            }
        }
    }
    
    func addNewGames() {
        //print("Starting addNewGames in RealmManager")
        // Create games and add to the existing Match
        if let realm = realm {
            
            do {
                let matchToUse = realm.objects(Match.self)[0]
                let settings = realm.objects(Settings.self)[0]
                try realm.write {
                    //print("matchToUse games.count before add: \(matchToUse.games.count)")
                    let game1 = Game()
                    game1.gameNumber = 1
                    game1.refereeName = settings.defaultRefereeName
                    matchToUse.games.append(game1)
                    let game2 = Game()
                    game2.gameNumber = 2
                    game2.refereeName = settings.defaultRefereeName
                    matchToUse.games.append(game2)
                    let game3 = Game()
                    game3.gameNumber = 3
                    game3.refereeName = settings.defaultRefereeName
                    matchToUse.games.append(game3)
                    let game4 = Game()
                    game4.gameNumber = 4
                    game4.refereeName = settings.defaultRefereeName
                    matchToUse.games.append(game4)
                    let game5 = Game()
                    game5.gameNumber = 5
                    game5.refereeName = settings.defaultRefereeName
                    matchToUse.games.append(game5)
                    //print("matchToUse games.count after add in addNewGames: \(matchToUse.games.count)")
                }
            } catch {
                print("Error adding games in Realm Manager")
            }
        }
    }
    
    func addNewScoringImages() {
        print("Starting addNewScoringImages in RealmManager")
        // Create ScoringImages and add to the existing Match
        if let realm = realm {
            do {
                let matchToUse = realm.objects(Match.self)[0]
                try realm.write {
                    let scoringImages = ScoringImages()
                    matchToUse.images.append(scoringImages)
                }
            } catch {
                print("Error adding images in Realm Manager")
            }
        }
    }
    
    func addNewViolation(match: Match) {
        // Create a violation and add to the existing Match violations
        let violation = Violation()
        match.violations.append(violation)
    }
    
    func archiveMatch(match: Match) {
        
        // Create an save ArchivedMatch object
        let archivedMatch = ArchivedMatch()
        if let realm = realm {
            archivedMatch.eventTitle = match.eventTitle
            archivedMatch.archiveDate = Date.now
            archivedMatch.finalGameScores = match.matchFinalGameScores
            archivedMatch.finalMatchScore = match.matchFinalScore
            archivedMatch.matchDate = match.matchDate
            archivedMatch.matchNumber = match.matchNumber
            archivedMatch.namePlayer1Team1 = match.namePlayer1Team1
            archivedMatch.namePlayer2Team1 = match.namePlayer2Team1
            archivedMatch.namePlayer1Team2 = match.namePlayer1Team2
            archivedMatch.namePlayer2Team2 = match.namePlayer2Team2
            let scoresheetImageToArchive = retrieveImage(forKey: "scoresheet", inStorageType: .fileSystem)
            guard let scoresheetImageDataToArchive = scoresheetImageToArchive!.pngData() else { return }
            archivedMatch.matchStatisticsImage = scoresheetImageDataToArchive
            let statisticsImageToArchive = retrieveImage(forKey: "statistics", inStorageType: .fileSystem)
            guard let statisticsImageDataToArchive = statisticsImageToArchive!.pngData() else { return }
            archivedMatch.scoresheetImage = statisticsImageDataToArchive
            do {
                try realm.write {
                    realm.add(archivedMatch)
                }
            } catch {
                print("Error adding ArchivedMatch in Realm Manager")
            }
            
            // Archived matches are limited to the last 20 matches (arbitrarily as a design decision based on display and memory concerens).
            // So delete oldest match if there are already 20 matches in the realm database so there will be room within the 20 limit for this match
            let archivedMatches = realm.objects(ArchivedMatch.self)
            if archivedMatches.count > 4 {
                do {
                    try realm.write {
                        realm.delete(archivedMatches[0])
                    }
                } catch {
                    print("Error deleting Match in Realm Manager")
                }
            }
        }
    }
    
    // TODO: - This is just for development - delete for production
    func createNewDevelopmentMatch () -> Match {
        print("Starting createNewDevelopmentMatch() in RealmManager")
        // TODO: - For production remove the values generated from seed data or hand coded and use default values
        let newMatch = Match()
        if let realm = realm {
            let settings = realm.objects(Settings.self)[0]
            newMatch.courtNumber = "\(Int.random(in: 1...16))"     // Default is "0"
            newMatch.eventTitle = EventNamesArray[Int.random(in: 1..<EventNamesArray.count)]                  // Default is ""
            newMatch.matchLocation = LocationArray[Int.random(in: 1..<LocationArray.count)]                   // Default is ""
            newMatch.namePlayer1Team1 = PlayerNamesArray[Int.random(in: 1..<PlayerNamesArray.count)]          // Default is ""
            newMatch.namePlayer2Team1 = PlayerNamesArray[Int.random(in: 1..<PlayerNamesArray.count)]          // Default is ""
            newMatch.namePlayer1Team2 = PlayerNamesArray[Int.random(in: 1..<PlayerNamesArray.count)]          // Default is ""
            newMatch.namePlayer2Team2 = PlayerNamesArray[Int.random(in: 1..<PlayerNamesArray.count)]          // Default is ""
            newMatch.firstServerDesignationGame1Team1 = "\(newMatch.player1FirstName)"                        // Default is ""
            newMatch.firstServerDesignationGame2Team1 = "X"                                                   // Default is ""
            newMatch.firstServerDesignationGame3Team1 = "\(newMatch.player1FirstName)"                        // Default is ""
            newMatch.firstServerDesignationGame4Team1 = "X"                                                   // Default is ""
            newMatch.firstServerDesignationGame5Team1 = "\(newMatch.player1FirstName)"                        // Default is ""
            newMatch.firstServerDesignationGame1Team2 = "X"                                                   // Default is ""
            newMatch.firstServerDesignationGame2Team2 = "\(newMatch.player3FirstName)"                        // Default is ""
            newMatch.firstServerDesignationGame3Team2 = "X"                                                   // Default is ""
            newMatch.firstServerDesignationGame4Team2 = "\(newMatch.player3FirstName)"                        // Default is ""
            newMatch.firstServerDesignationGame5Team2 = "X"                                                  // Default is ""
            newMatch.isMatchSetupCompleted = true     // Default is "false
            newMatch.isServerSideSet = true           // Default is "false
            newMatch.matchNotes = "Water breaks every 30 minutes"     // Default is ""
            newMatch.matchNumber = "\(Int.random(in: 1...97))"        // Default is "0"
            newMatch.matchStartingServerName = "Undetermined"   // Default is ""
            newMatch.matchStartingServerNumber = 1              // Default is 0
            newMatch.player1Team1Identifiers = "Red Hat"        // Default is ""
            newMatch.player2Team1Identifiers = "Blonde"         // Default is ""
            newMatch.player1Team2Identifiers = "Blue Shorts"    // Default is ""
            newMatch.player2Team2Identifiers = "Green Shoes"    // Default is ""
            newMatch.selectedMatchFormat = 1                    // Default is 2
            newMatch.selectedPointsToWin = 7                    // Default is 11
            newMatch.servingPlayerNumber = 1                    // Default is 0
            newMatch.specialTeam1 = "Special 1"                 // Default is ""
            newMatch.specialTeam2 = "Special 2"                 // Default is ""
            newMatch.matchStartDateValue = Calendar.current.date(byAdding: .minute, value: -30, to: Date())!  // default is Date.now
            let game1 = Game()
            game1.gameNumber = 1
            game1.refereeName = settings.defaultRefereeName
            game1.gameFirstServerPlayerNumber = 1               // Default is 0
            game1.selectedFirstServerTeam1 = 1                  // Default is 0
            game1.selectedFirstServerTeam2 = 4                  // Default is 0
            newMatch.games.append(game1)
            let game2 = Game()
            game2.gameNumber = 2
            game2.refereeName = settings.defaultRefereeName
            game2.gameFirstServerPlayerNumber = 3               // Default is 0
            game2.selectedFirstServerTeam1 = 2                  // Default is 0
            game2.selectedFirstServerTeam2 = 3                  // Default is 0
            newMatch.games.append(game2)
            let game3 = Game()
            game3.gameNumber = 3
            game3.refereeName = settings.defaultRefereeName
            game3.gameFirstServerPlayerNumber = 2               // Default is 0
            game3.selectedFirstServerTeam1 = 2                  // Default is 0
            game3.selectedFirstServerTeam2 = 4                  // Default is 0
            newMatch.games.append(game3)
            let game4 = Game()
            game4.gameNumber = 4
            game4.refereeName = settings.defaultRefereeName
            game4.gameFirstServerPlayerNumber = 1               // Default is 0
            game4.selectedFirstServerTeam1 = 1                  // Default is 0
            game4.selectedFirstServerTeam2 = 4                  // Default is 0
            newMatch.games.append(game4)
            let game5 = Game()
            game5.gameNumber = 5
            game5.refereeName = settings.defaultRefereeName
            game5.gameFirstServerPlayerNumber = 1               // Default is 0
            game5.selectedFirstServerTeam1 = 1                  // Default is 0
            game5.selectedFirstServerTeam2 = 4                  // Default is 0
            newMatch.games.append(game5)
            newMatch.images.append(ScoringImages())
            do {
                try realm.write {
                    realm.add(newMatch)
                }
            } catch {
                print("Error adding Match in Realm Manager")
            }
        }
        return newMatch
    }
    
    func createNewMatch () -> Match {
        let newMatch = Match()
        if let realm = realm {
            let settings = realm.objects(Settings.self)[0]
            
            newMatch.courtNumber = ""
            newMatch.eventTitle = settings.defaultEventTitle
            newMatch.emailAddressForScoresheetSnaphot = settings.defaultEmailAddress
            newMatch.emailAddressForUser = settings.defaultUserEmailAddress
            newMatch.matchLocation = settings.defaultLocation
            newMatch.numberOfTimeoutsPerGame = settings.numberOfTimeoutsPerGame
            newMatch.selectedDoublesPlay = settings.selectedDoublesPlay
            newMatch.selectedMatchFormat = settings.selectedMatchFormat
            newMatch.selectedPointsToWin = settings.selectedPointsToWin
            newMatch.selectedScoringFormat = settings.selectedScoringFormat
            
            let game1 = Game()
            game1.gameNumber = 1
            game1.refereeName = settings.defaultRefereeName
            newMatch.games.append(game1)
            let game2 = Game()
            game2.gameNumber = 2
            game2.refereeName = settings.defaultRefereeName
            newMatch.games.append(game2)
            let game3 = Game()
            game3.gameNumber = 3
            game3.refereeName = settings.defaultRefereeName
            newMatch.games.append(game3)
            let game4 = Game()
            game4.gameNumber = 4
            game4.refereeName = settings.defaultRefereeName
            newMatch.games.append(game4)
            let game5 = Game()
            game5.gameNumber = 5
            game5.refereeName = settings.defaultRefereeName
            newMatch.games.append(game5)
            newMatch.images.append(ScoringImages())
            do {
                try realm.write {
                    realm.add(newMatch)
                }
            } catch {
                print("Error adding Match in Realm Manager")
            }
        }
        return newMatch
    }
    
    
    func createNewSettings() {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(Settings())
                }
            } catch {
                print("Error saving new Settings: \(error)")
            }
        }
    }
    
    
    //func deleteGames(for match: Match) {
    func deleteGames() {
        if let realm = realm {
            do {
                let matchToUse = realm.objects(Match.self)[0]
                try realm.write {
                    //print("matchToUse games.count before deletes: \(matchToUse.games.count)")
                    realm.delete(matchToUse.games[4])
                    realm.delete(matchToUse.games[3])
                    realm.delete(matchToUse.games[2])
                    realm.delete(matchToUse.games[1])
                    realm.delete(matchToUse.games[0])
                    //print("matchToUse games.count after deletes: \(matchToUse.games.count)")
                    
                }
            } catch {
                print("Error deleting games in Realm Manager")
            }
        }
    }
    
    
    func deleteScoringImages() {
        print("Starting deleteScoringImages() in RealmManager")
        if let realm = realm {
            do {
                try realm.write {
                    let matchToUse = realm.objects(Match.self)[0]
                    realm.delete(matchToUse.images[0])
                }
            } catch {
                print("Error deleting images in Realm Manager")
            }
        }
    }
    
    func deleteViolations() {
        print("Starting deleteViolations() in RealmManager")
        if let realm = realm {
            do {
                try realm.write {
                    let matchToUse = realm.objects(Match.self)[0]
                    if matchToUse.violations.count > 0 {
                        realm.delete(matchToUse.violations[0])
                    }
                }
            } catch {
                print("Error deleting images in Realm Manager")
            }
        }
    }
    
    func getPlayerWarningsCountForGame(playerNumber: Int, gameNumber: Int) -> Int {
        var warningsCount = 0
        if let realm = realm {
            let playerWarnings = realm.objects(Match.self).where { ($0.isCompleted == true && $0.violations.playerNumber == playerNumber && $0.violations.gameNumber == gameNumber && $0.violations.isWarning == true) }
            warningsCount = playerWarnings.count
        }
        return warningsCount
    }
    
    func getPlayerWarningsCountForMatch(playerNumber: Int) -> Int {
        var warningsCount = 0
        if let realm = realm {
            let playerWarnings = realm.objects(Match.self).where { ($0.isCompleted == true && $0.violations.playerNumber == playerNumber && $0.violations.isWarning == true) }
            warningsCount = playerWarnings.count
        }
        return warningsCount
    }
    
    func getPlayerFoulsCountForGame(playerNumber: Int, gameNumber: Int) -> Int {
        var foulsCount = 0
        if let realm = realm {
            let playerFouls = realm.objects(Match.self).where { ($0.isCompleted == true && $0.violations.playerNumber == playerNumber && $0.violations.gameNumber == gameNumber && $0.violations.isWarning == false) }
            foulsCount = playerFouls.count
        }
        return foulsCount
    }
    func getPlayerFoulsCountForMatch(playerNumber: Int) -> Int {
        var foulsCount = 0
        if let realm = realm {
            let playerFouls = realm.objects(Match.self).where { ($0.isCompleted == true && $0.violations.playerNumber == playerNumber && $0.violations.isWarning == false) }
            foulsCount = playerFouls.count
        }
        return foulsCount
    }
    
    func getPlayerViolationsCount(playerNumber: Int, isWarnings: Bool) -> Int {
        
        var playerViolationsCount = 0
        if let realm = realm {
            if isWarnings {
                let allPlayerWarnings = realm.objects(Match.self).where { ($0.violations.playerNumber == playerNumber && $0.violations.isWarning == true) }
                playerViolationsCount = allPlayerWarnings.count
            } else {
                let allPlayerFouls = realm.objects(Match.self).where { ($0.violations.playerNumber == playerNumber && $0.violations.isWarning == false) }
                playerViolationsCount = allPlayerFouls.count
            }
        }
        return playerViolationsCount
    }
    
    func getPlayerViolationsDisplay(playerNumber: Int, isWarnings: Bool) -> String {
        
        var violationsDisplay = ""
        var violationType = ""
        var violationDescription = ""
        var violationNumber = 0
        if let realm = realm {
            let match = realm.objects(Match.self)[0]
            let violationsArray = Array(match.violations)
            if isWarnings {
                let violationsArrayCount = violationsArray.count
                if violationsArrayCount > 0 {
                    for var i in 0..<(violationsArrayCount) {
                        let violation = violationsArray[i]
                        if violation.playerNumber == playerNumber && violation.isWarning == true {
                            violationDescription += "\(violation.violationDescription)"
                            violationNumber = violation.violation
                            switch violationNumber {
                            case 1:
                                violationType += "Breaking Ball"
                            case 2:
                                violationType += "Cursing"
                            case 3:
                                violationType += "Excessive Appeals"
                            case 4:
                                violationType += "Excessive Arguing"
                            case 5:
                                violationType += "Excessive Questioning"
                            case 6:
                                violationType += "Striking the Ball"
                            case 7:
                                violationType += "Too Much Time"
                            case 8:
                                violationType += "Threats"
                            case 9:
                                violationType += "Throwing Paddle"
                            case 10:
                                violationType += "Other Behavior"
                            default:
                                print("Error setting violationType in RealmManager")
                            }
                            violationsDisplay += "\(violationType): \(violationDescription)\n"
                            violationDescription = ""
                            violationNumber = 0
                            i += 1
                        }
                    }
                }
            } else {
                // this is Technical Fouls
                let violationsArrayCount = violationsArray.count
                if violationsArrayCount > 0 {
                    for var i in 0..<(violationsArrayCount) {
                        let violation = violationsArray[i]
                        if violation.playerNumber == playerNumber && violation.isWarning == false {
                            violationDescription += "\(violation.violationDescription)"
                            violationNumber = violation.violation
                            switch violationNumber {
                            case 1:
                                violationType += "Breaking Ball"
                            case 2:
                                violationType += "Cursing"
                            case 3:
                                violationType += "Excessive Appeals"
                            case 4:
                                violationType += "Excessive Arguing"
                            case 5:
                                violationType += "Excessive Questioning"
                            case 6:
                                violationType += "Striking the Ball"
                            case 7:
                                violationType += "Too Much Time"
                            case 8:
                                violationType += "Threats"
                            case 9:
                                violationType += "Throwing Paddle"
                            case 10:
                                violationType += "Other Behavior"
                            default:
                                print("Error setting violationType in RealmManager")
                            }
                            violationsDisplay += "\(violationType): \(violationDescription)\n"
                            violationDescription = ""
                            violationNumber = 0
                            i += 1
                        }
                    }
                }
            }
            //print("violationsDisplay at end of for loop in getPlayerViolationsDisplay: \(violationsDisplay)")
        }
        return violationsDisplay
    }
    
    func initializeSchema() {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let realmFileUrl = docDir.appendingPathComponent("pickleball.realm")
        
        let config = Realm.Configuration(fileURL: realmFileUrl, schemaVersion: 1) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: Match.className()) { _, newObject in
                    //newObject!["ballType"] = "Dura Fast 40"
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
        // Print path so can look at database
        print(docDir.path)
        
        do {
            realm = try Realm()
        } catch {
            print("Error opening default realm: ", error.localizedDescription)
        }
    }
    
    func saveViolation (_ newViolation: Violation) {
        //Check that realm is instantiated
        if let realm = realm {
            do {
                let match = realm.objects(Match.self)[0]
                try realm.write {
                    match.violations.append(newViolation)
                }
            } catch {
                print("Error adding ArchivedMatch in Realm Manager")
            }
        }
    }
    
    func setupObserver() {
        guard let realm = realm else { return }
        let observedMatches = realm.objects(Match.self)
        matchesToken = observedMatches.observe( { [weak self] _ in
            self?.matches = observedMatches
        })
    }
}


// Query to linked objects with realm
// Realm LinkingObjects objects don't represent a single object; they represent an array of potentially multiple objects. As such, it's necessary to query to see if your object exists in that array, instead of querying for equality.
//let engines = realm.objects(Engine.self).filter("%@ IN parent", loco)
//
//        class Project: Object, ObjectKeyIdentifiable {
//           @Persisted var name = ""
//           @Persisted var tasks: List<Task>
//        }
//        let myActiveProjects = realm.objects(Project.self).where {
//           ($0.tasks.progressMinutes >= 1) && ($0.tasks.assignee == name)
//        }


// Using Enum with reaom
//enum Kind: String {
//  case CheckedIn
//  case EnRoute
//  case DroppedOff
//}
//
//class Checkin: Object {
//  @objc dynamic var id = 0
//  var kind = Kind.CheckedIn.rawValue
//  var kindEnum: Kind {
//    get {
//      return Kind(rawValue: kind)!
//    }
//    set {
//      kind = newValue.rawValue
//    }
//  }
//}

//realm.delete(Realm.objects(ChecklistDataModel.self).filter("name=%@",checklists[indexPath.row].name))
//
//let predicate = NSPredicate(format: "UUID == %@", product.uuid)
//if let productToDelete = realm.object(RMProduct.self)
//                              .filter(predicate).first {
//      realm.delete(productToDelete)
//}

