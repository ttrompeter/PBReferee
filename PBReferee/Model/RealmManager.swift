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
    
    func createPointImages() -> RealmSwift.List<PointImage> {
        
        /*
         Give each PointImage a unique number
         - - - - - - - - - - - - - - - - - - -
         For Team 1
         Game 1:    1 - 21  (need to allow for further expansion up to 30 points per game in case game goes longer than 21 points)
         Game 2:   31 - 51
         Game 3:   61 - 81
         Game 4:  101 - 121
         Game 5:  131 - 151
         Game 3A: 401 - 421
         - - - - - - - - - - - - - - - - - - -
         For Team 2
         Game 1:  201 - 221  (need to allow for further expansion up to 30 points per game in case game goes longer than 21 points)
         Game 2:  231 - 251
         Game 3:  261 - 281
         Game 4:  301 - 321
         Game 5:  331 - 351
         Game 3A: 501 - 521
         */
        
        let returnList = RealmSwift.List<PointImage>()
        var rowNumber = 0
        
        // Game 1 PointImages Team 1
        for var i in 1..<21  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage1 = PointImage()
        newPointImage1.rowNumber = rowNumber
        newPointImage1.boxNumber = 21
        newPointImage1.pointNumber = 21
        newPointImage1.boxImageName = "boxrightend"
        returnList.append(newPointImage1)
        rowNumber += 1
        
        // Game 2 PointImages Team 1
        for var i in 31..<51  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 30
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage2 = PointImage()
        newPointImage2.rowNumber = rowNumber
        newPointImage2.boxNumber = 21
        newPointImage2.pointNumber = 51
        newPointImage2.boxImageName = "boxrightend"
        returnList.append(newPointImage2)
        rowNumber += 1
        
        // Game 3 PointImages Team 1
        for var i in 61..<81  {
            let newPointImage = PointImage()
            newPointImage.boxNumber = i - 60
            newPointImage.rowNumber = rowNumber
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxbottomrowleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage3 = PointImage()
        newPointImage3.rowNumber = rowNumber
        newPointImage3.boxNumber = 21
        newPointImage3.pointNumber = 81
        newPointImage3.boxImageName = "box"
        returnList.append(newPointImage3)
        rowNumber += 1
        
        // Game 4 PointImages Team 1
        for var i in 101..<121  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 100
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage4 = PointImage()
        newPointImage4.rowNumber = rowNumber
        newPointImage4.boxNumber = 21
        newPointImage4.pointNumber = 121
        newPointImage4.boxImageName = "boxrightend"
        returnList.append(newPointImage4)
        rowNumber += 1
        
        // Game 5 PointImages Team 1
        for var i in 131..<151  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 130
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxbottomrowleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage5 = PointImage()
        newPointImage5.rowNumber = rowNumber
        newPointImage5.boxNumber = 21
        newPointImage5.pointNumber = 151
        newPointImage5.boxImageName = "box"
        returnList.append(newPointImage5)
        rowNumber += 1
        
        // Game 1 PointImages Team 2
        for var i in 201..<221  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 200
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage21 = PointImage()
        newPointImage21.rowNumber = rowNumber
        newPointImage21.boxNumber = 21
        newPointImage21.pointNumber = 221
        newPointImage21.boxImageName = "boxrightend"
        returnList.append(newPointImage21)
        rowNumber += 1
        print("After Game 1 points for Team 2 returnList. count: \(returnList.count)")
        
        // Game 2 PointImages Team 2
        for var i in 231..<251  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 230
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage22 = PointImage()
        newPointImage22.rowNumber = rowNumber
        newPointImage22.boxNumber = 21
        newPointImage22.pointNumber = 251
        newPointImage22.boxImageName = "boxrightend"
        returnList.append(newPointImage22)
        rowNumber += 1
        
        // Game 3 PointImages Team 2
        for var i in 261..<281  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 260
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxbottomrowleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage23 = PointImage()
        newPointImage23.rowNumber = rowNumber
        newPointImage23.boxNumber = 21
        newPointImage23.pointNumber = 281
        newPointImage23.boxImageName = "box"
        returnList.append(newPointImage23)
        rowNumber += 1
        
        // Game 4 PointImages Team 2
        for var i in 301..<321  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 300
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage24 = PointImage()
        newPointImage24.rowNumber = rowNumber
        newPointImage24.boxNumber = 21
        newPointImage24.pointNumber = 321
        newPointImage24.boxImageName = "boxrightend"
        returnList.append(newPointImage24)
        rowNumber += 1
        
        // Game 5 PointImages Team 2
        for var i in 331..<351  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 330
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxbottomrowleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage25 = PointImage()
        newPointImage25.rowNumber = rowNumber
        newPointImage25.boxNumber = 21
        newPointImage25.pointNumber = 351
        newPointImage25.boxImageName = "box"
        returnList.append(newPointImage25)
        rowNumber += 1
        print("After Game 5 points for Team 2 returnList. count: \(returnList.count)")
        
        // Game 3A PointImages Team 1
        for var i in 401..<421  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 400
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxbottomrowleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage33 = PointImage()
        newPointImage33.rowNumber = rowNumber
        newPointImage33.boxNumber = 21
        newPointImage33.pointNumber = 421
        newPointImage33.boxImageName = "box"
        returnList.append(newPointImage33)
        rowNumber += 1
        
        // Game 3A PointImages Team 2
        for var i in 501..<521  {
            let newPointImage = PointImage()
            newPointImage.rowNumber = rowNumber
            newPointImage.boxNumber = i - 500
            newPointImage.pointNumber = i
            newPointImage.boxImageName = "boxbottomrowleft"
            returnList.append(newPointImage)
            i += 1
            rowNumber += 1
        }
        let newPointImage34 = PointImage()
        newPointImage34.rowNumber = rowNumber
        newPointImage34.boxNumber = 21
        newPointImage34.pointNumber = 521
        newPointImage34.boxImageName = "box"
        returnList.append(newPointImage34)
        rowNumber += 1
        
        
        return returnList
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
            //game1.points = createGamePointImages(gameNumber: game1.gameNumber)
            newMatch.games.append(game1)
            let game2 = Game()
            game2.gameNumber = 2
            game2.refereeName = settings.defaultRefereeName
            game2.gameFirstServerPlayerNumber = 3               // Default is 0
            game2.selectedFirstServerTeam1 = 2                  // Default is 0
            game2.selectedFirstServerTeam2 = 3                  // Default is 0
            //game2.points = createGamePointImages(gameNumber: game2.gameNumber)
            newMatch.games.append(game2)
            let game3 = Game()
            game3.gameNumber = 3
            game3.refereeName = settings.defaultRefereeName
            game3.gameFirstServerPlayerNumber = 2               // Default is 0
            game3.selectedFirstServerTeam1 = 2                  // Default is 0
            game3.selectedFirstServerTeam2 = 4                  // Default is 0
            //game3.points = createGamePointImages(gameNumber: game3.gameNumber)
            newMatch.games.append(game3)
            let game4 = Game()
            game4.gameNumber = 4
            game4.refereeName = settings.defaultRefereeName
            game4.gameFirstServerPlayerNumber = 1               // Default is 0
            game4.selectedFirstServerTeam1 = 1                  // Default is 0
            game4.selectedFirstServerTeam2 = 4                  // Default is 0
            //game4.points = createGamePointImages(gameNumber: game4.gameNumber)
            newMatch.games.append(game4)
            let game5 = Game()
            game5.gameNumber = 5
            game5.refereeName = settings.defaultRefereeName
            game5.gameFirstServerPlayerNumber = 1               // Default is 0
            game5.selectedFirstServerTeam1 = 1                  // Default is 0
            game5.selectedFirstServerTeam2 = 4                  // Default is 0
            //game5.points = createGamePointImages(gameNumber: game5.gameNumber)
            newMatch.games.append(game5)
            //newMatch.images.append(ScoringImages())
            newMatch.points = createPointImages()
            newMatch.timeouts = createTimeOutImages()
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
    
//    func createGamePointImages(gameNumber: Int) -> RealmSwift.List<PointImage> {
//        /*
//         Give each PointImage a unique number
//         Game 1: 1 - 21  (allow for further expansion up to 30 in case game goes longer than 21 points)
//         Game 2: 31 - 52
//         Game 3: 61 - 82
//         Game 4: 101 - 122
//         Game 5: 131 - 152
//         */
//        let returnList = RealmSwift.List<PointImage>()
//        switch gameNumber {
//        case 1:
//            // Game 1 PointImages
//            for var i in 1..<21  {
//                let newPointImage = PointImage()
//                newPointImage.boxNumber = i
//                newPointImage.pointNumber = i
//                newPointImage.boxImageName = "boxleft"
//                returnList.append(newPointImage)
//                i += 1
//            }
//            let newPointImage = PointImage()
//            newPointImage.boxNumber = 21
//            newPointImage.pointNumber = 21
//            newPointImage.boxImageName = "boxrightend"
//            returnList.append(newPointImage)
//            //print("returnList count for Game 1 in RealmManager: \(returnList.count)")
//            //print("returnList[1] for Game 1 in in RealmManager: \(returnList[0])")
//        case 2:
//            // Game 2 PointImages
//            for var i in 31..<51  {
//                let newPointImage = PointImage()
//                newPointImage.boxNumber = i - 30
//                newPointImage.pointNumber = i
//                newPointImage.boxImageName = "boxleft"
//                returnList.append(newPointImage)
//                i += 1
//            }
//            let newPointImage = PointImage()
//            newPointImage.boxNumber = 51
//            newPointImage.pointNumber = 51
//            newPointImage.boxImageName = "boxrightend"
//            returnList.append(newPointImage)
//        case 3:
//            // Game 3 PointImages
//            for var i in 61..<81  {
//                let newPointImage = PointImage()
//                newPointImage.boxNumber = i - 60
//                newPointImage.pointNumber = i
//                newPointImage.boxImageName = "boxbottomrowleft"
//                returnList.append(newPointImage)
//                i += 1
//            }
//            let newPointImage = PointImage()
//            newPointImage.boxNumber = 81 - 60
//            newPointImage.pointNumber = 81
//            newPointImage.boxImageName = "box"
//            returnList.append(newPointImage)
//        case 4:
//            // Game 4 PointImages
//            for var i in 101..<121  {
//                let newPointImage = PointImage()
//                newPointImage.boxNumber = i - 100
//                newPointImage.pointNumber = i
//                newPointImage.boxImageName = "boxleft"
//                returnList.append(newPointImage)
//                i += 1
//            }
//            let newPointImage = PointImage()
//            newPointImage.boxNumber = 121 - 100
//            newPointImage.pointNumber = 121
//            newPointImage.boxImageName = "boxrightend"
//            returnList.append(newPointImage)
//        case 5:
//            // Game 5 PointImages
//            for var i in 131..<151  {
//                let newPointImage = PointImage()
//                newPointImage.boxNumber = i - 130
//                newPointImage.pointNumber = i
//                newPointImage.boxImageName = "boxbottomrowleft"
//                returnList.append(newPointImage)
//                i += 1
//            }
//            let newPointImage = PointImage()
//            newPointImage.boxNumber = 151 - 130
//            newPointImage.pointNumber = 151
//            newPointImage.boxImageName = "box"
//            returnList.append(newPointImage)
//            //print("returnList count for Game 5 in RealmManager: \(returnList.count)")
//            //print("returnList[20] in for Game 5 RealmManager: \(returnList[20])")
//        default:
//            print("Error creating game point images in createGamePointImages() in RealmManager")
//        }
//
//        return returnList
//    }
    
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
            //newMatch.images.append(ScoringImages())
            newMatch.points = createPointImages()
            newMatch.timeouts = createTimeOutImages()
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
    
    func createTimeOutImages() -> RealmSwift.List<TimeOutImage> {
        
        let returnList = RealmSwift.List<TimeOutImage>()
        var rowNumber = 0
        
        // Timeouts Game 1 Team 1
        let newTimeoutG1T1T1Image = TimeOutImage()
        newTimeoutG1T1T1Image.rowNumber = rowNumber
        newTimeoutG1T1T1Image.boxImageName = "boxleft"
        newTimeoutG1T1T1Image.boxNumber = "1"
        newTimeoutG1T1T1Image.timeOutNumber = 1
        returnList.append(newTimeoutG1T1T1Image)
        rowNumber += 1
       
        let newTimeoutG1T2T1Image = TimeOutImage()
        newTimeoutG1T2T1Image.rowNumber = rowNumber
        newTimeoutG1T2T1Image.boxImageName = "boxrightend"
        newTimeoutG1T2T1Image.boxNumber = "2"
        newTimeoutG1T2T1Image.timeOutNumber = 2
        returnList.append(newTimeoutG1T2T1Image)
        rowNumber += 1
        
        let newTimeoutG1T3T1Image = TimeOutImage()
        newTimeoutG1T3T1Image.rowNumber = rowNumber
        newTimeoutG1T3T1Image.boxImageName = "boxblank"
        newTimeoutG1T3T1Image.boxNumber = ""
        newTimeoutG1T3T1Image.timeOutNumber = 3
        returnList.append(newTimeoutG1T3T1Image)
        rowNumber += 1
        
        // Timeouts Game 2 Team 1
        let newTimeoutG2T1T1Image = TimeOutImage()
        newTimeoutG2T1T1Image.rowNumber = rowNumber
        newTimeoutG2T1T1Image.boxImageName = "boxleft"
        newTimeoutG2T1T1Image.boxNumber = "1"
        newTimeoutG2T1T1Image.timeOutNumber = 4
        returnList.append(newTimeoutG2T1T1Image)
        rowNumber += 1
       
        let newTimeoutG2T2T1Image = TimeOutImage()
        newTimeoutG2T2T1Image.rowNumber = rowNumber
        newTimeoutG2T2T1Image.boxImageName = "boxrightend"
        newTimeoutG2T2T1Image.boxNumber = "2"
        newTimeoutG2T2T1Image.timeOutNumber = 5
        returnList.append(newTimeoutG2T2T1Image)
        rowNumber += 1
        
        let newTimeoutG2T3T1Image = TimeOutImage()
        newTimeoutG2T3T1Image.rowNumber = rowNumber
        newTimeoutG2T3T1Image.boxImageName = "boxblank"
        newTimeoutG2T3T1Image.boxNumber = ""
        newTimeoutG2T3T1Image.timeOutNumber = 6
        returnList.append(newTimeoutG2T3T1Image)
        rowNumber += 1

        // Timeouts Game 3 Team 1
        let newTimeoutG3T1T1Image = TimeOutImage()
        newTimeoutG3T1T1Image.rowNumber = rowNumber
        newTimeoutG3T1T1Image.boxImageName = "boxbottomrowleft"
        newTimeoutG3T1T1Image.boxNumber = "1"
        newTimeoutG3T1T1Image.timeOutNumber = 7
        returnList.append(newTimeoutG3T1T1Image)
        rowNumber += 1
       
        let newTimeoutG3T2T1Image = TimeOutImage()
        newTimeoutG3T2T1Image.rowNumber = rowNumber
        newTimeoutG3T2T1Image.boxImageName = "box"
        newTimeoutG3T2T1Image.boxNumber = "2"
        newTimeoutG3T2T1Image.timeOutNumber = 8
        returnList.append(newTimeoutG3T2T1Image)
        rowNumber += 1
        
        let newTimeoutG3T3T1Image = TimeOutImage()
        newTimeoutG3T3T1Image.rowNumber = rowNumber
        newTimeoutG3T3T1Image.boxImageName = "boxblank"
        newTimeoutG3T3T1Image.boxNumber = ""
        newTimeoutG3T3T1Image.timeOutNumber = 9
        returnList.append(newTimeoutG3T3T1Image)
        rowNumber += 1
        
        // Timeouts Game 4 Team 1
        let newTimeoutG4T1T1Image = TimeOutImage()
        newTimeoutG4T1T1Image.rowNumber = rowNumber
        newTimeoutG4T1T1Image.boxImageName = "boxleft"
        newTimeoutG4T1T1Image.boxNumber = "1"
        newTimeoutG4T1T1Image.timeOutNumber = 10
        returnList.append(newTimeoutG4T1T1Image)
        rowNumber += 1
        
        let newTimeoutG4T2T1Image = TimeOutImage()
        newTimeoutG4T2T1Image.rowNumber = rowNumber
        newTimeoutG4T2T1Image.boxImageName = "boxrightend"
        newTimeoutG4T2T1Image.boxNumber = "2"
        newTimeoutG4T2T1Image.timeOutNumber = 11
        returnList.append(newTimeoutG4T2T1Image)
        rowNumber += 1
        
        let newTimeoutG4T3T1Image = TimeOutImage()
        newTimeoutG4T3T1Image.rowNumber = rowNumber
        newTimeoutG4T3T1Image.boxImageName = "boxblank"
        newTimeoutG4T3T1Image.boxNumber = ""
        newTimeoutG4T3T1Image.timeOutNumber = 12
        returnList.append(newTimeoutG4T3T1Image)
        rowNumber += 1
        
        // Timeouts Game 5 Team 1
        let newTimeoutG5T1T1Image = TimeOutImage()
        newTimeoutG5T1T1Image.rowNumber = rowNumber
        newTimeoutG5T1T1Image.boxImageName = "boxbottomrowleft"
        newTimeoutG5T1T1Image.boxNumber = "1"
        newTimeoutG5T1T1Image.timeOutNumber = 13
        returnList.append(newTimeoutG5T1T1Image)
        rowNumber += 1
        
        let newTimeoutG5T2T1Image = TimeOutImage()
        newTimeoutG5T2T1Image.rowNumber = rowNumber
        newTimeoutG5T2T1Image.boxImageName = "box"
        newTimeoutG5T2T1Image.boxNumber = "2"
        newTimeoutG5T2T1Image.timeOutNumber = 14
        returnList.append(newTimeoutG5T2T1Image)
        rowNumber += 1
        
        let newTimeoutG5T3T1Image = TimeOutImage()
        newTimeoutG5T3T1Image.rowNumber = rowNumber
        newTimeoutG5T3T1Image.boxImageName = "boxblank"
        newTimeoutG5T3T1Image.boxNumber = ""
        newTimeoutG5T3T1Image.timeOutNumber = 15
        returnList.append(newTimeoutG5T3T1Image)
        rowNumber += 1

        // Timeouts Game 1 Team 2
        let newTimeoutG1T1T2Image = TimeOutImage()
        newTimeoutG1T1T2Image.rowNumber = rowNumber
        newTimeoutG1T1T2Image.boxImageName = "boxleft"
        newTimeoutG1T1T2Image.boxNumber = "1"
        newTimeoutG1T1T2Image.timeOutNumber = 16
        returnList.append(newTimeoutG1T1T2Image)
        rowNumber += 1

        let newTimeoutG1T2T2Image = TimeOutImage()
        newTimeoutG1T2T2Image.rowNumber = rowNumber
        newTimeoutG1T2T2Image.boxImageName = "boxrightend"
        newTimeoutG1T2T2Image.boxNumber = "2"
        newTimeoutG1T2T2Image.timeOutNumber = 17
        returnList.append(newTimeoutG1T2T2Image)
        rowNumber += 1

        let newTimeoutG1T3T2Image = TimeOutImage()
        newTimeoutG1T3T2Image.rowNumber = rowNumber
        newTimeoutG1T3T2Image.boxImageName = "boxblank"
        newTimeoutG1T3T2Image.boxNumber = ""
        newTimeoutG1T3T2Image.timeOutNumber = 18
        returnList.append(newTimeoutG1T3T2Image)
        rowNumber += 1

        // Timeouts Game 2 Team 2
        let newTimeoutG2T1T2Image = TimeOutImage()
        newTimeoutG2T1T2Image.rowNumber = rowNumber
        newTimeoutG2T1T2Image.boxImageName = "boxleft"
        newTimeoutG2T1T2Image.boxNumber = "1"
        newTimeoutG2T1T2Image.timeOutNumber = 19
        returnList.append(newTimeoutG2T1T2Image)
        rowNumber += 1

        let newTimeoutG2T2T2Image = TimeOutImage()
        newTimeoutG2T2T2Image.rowNumber = rowNumber
        newTimeoutG2T2T2Image.boxImageName = "boxrightend"
        newTimeoutG2T2T2Image.boxNumber = "2"
        newTimeoutG2T2T2Image.timeOutNumber = 20
        returnList.append(newTimeoutG2T2T2Image)
        rowNumber += 1

        let newTimeoutG2T3T2Image = TimeOutImage()
        newTimeoutG2T3T2Image.rowNumber = rowNumber
        newTimeoutG2T3T2Image.boxImageName = "boxblank"
        newTimeoutG2T3T2Image.boxNumber = ""
        newTimeoutG2T3T2Image.timeOutNumber = 21
        returnList.append(newTimeoutG2T3T2Image)
        rowNumber += 1

        // Timeouts Game 3 Team 2
        let newTimeoutG3T1T2Image = TimeOutImage()
        newTimeoutG3T1T2Image.rowNumber = rowNumber
        newTimeoutG3T1T2Image.boxImageName = "boxbottomrowleft"
        newTimeoutG3T1T2Image.boxNumber = "1"
        newTimeoutG3T1T2Image.timeOutNumber = 22
        returnList.append(newTimeoutG3T1T2Image)
        rowNumber += 1

        let newTimeoutG3T2T2Image = TimeOutImage()
        newTimeoutG3T2T2Image.rowNumber = rowNumber
        newTimeoutG3T2T2Image.boxImageName = "box"
        newTimeoutG3T2T2Image.boxNumber = "2"
        newTimeoutG3T2T2Image.timeOutNumber = 23
        returnList.append(newTimeoutG3T2T2Image)
        rowNumber += 1

        let newTimeoutG3T3T2Image = TimeOutImage()
        newTimeoutG3T3T2Image.rowNumber = rowNumber
        newTimeoutG3T3T2Image.boxImageName = "boxblank"
        newTimeoutG3T3T2Image.boxNumber = ""
        newTimeoutG3T3T2Image.timeOutNumber = 24
        returnList.append(newTimeoutG3T3T2Image)
        rowNumber += 1

        // Timeouts Game 4 Team 2
        let newTimeoutG4T1T2Image = TimeOutImage()
        newTimeoutG4T1T2Image.rowNumber = rowNumber
        newTimeoutG4T1T2Image.boxImageName = "boxleft"
        newTimeoutG4T1T2Image.boxNumber = "1"
        newTimeoutG4T1T2Image.timeOutNumber = 25
        returnList.append(newTimeoutG4T1T2Image)
        rowNumber += 1

        let newTimeoutG4T2T2Image = TimeOutImage()
        newTimeoutG4T2T2Image.rowNumber = rowNumber
        newTimeoutG4T2T2Image.boxImageName = "boxrightend"
        newTimeoutG4T2T2Image.boxNumber = "2"
        newTimeoutG4T2T2Image.timeOutNumber = 26
        returnList.append(newTimeoutG4T2T2Image)
        rowNumber += 1

        let newTimeoutG4T3T2Image = TimeOutImage()
        newTimeoutG4T3T2Image.rowNumber = rowNumber
        newTimeoutG4T3T2Image.boxImageName = "boxblank"
        newTimeoutG4T3T2Image.boxNumber = ""
        newTimeoutG4T3T2Image.timeOutNumber = 27
        returnList.append(newTimeoutG4T3T2Image)
        rowNumber += 1

        // Timeouts Game 5 Team 2
        let newTimeoutG5T1T2Image = TimeOutImage()
        newTimeoutG5T1T2Image.rowNumber = rowNumber
        newTimeoutG5T1T2Image.boxImageName = "boxbottomrowleft"
        newTimeoutG5T1T2Image.boxNumber = "1"
        newTimeoutG5T1T2Image.timeOutNumber = 28
        returnList.append(newTimeoutG5T1T2Image)
        rowNumber += 1

        let newTimeoutG5T2T2Image = TimeOutImage()
        newTimeoutG5T2T2Image.rowNumber = rowNumber
        newTimeoutG5T2T2Image.boxImageName = "box"
        newTimeoutG5T2T2Image.boxNumber = "2"
        newTimeoutG5T2T2Image.timeOutNumber = 29
        returnList.append(newTimeoutG5T2T2Image)
        rowNumber += 1

        let newTimeoutG5T3T2Image = TimeOutImage()
        newTimeoutG5T3T2Image.rowNumber = rowNumber
        newTimeoutG5T3T2Image.boxImageName = "boxblank"
        newTimeoutG5T3T2Image.boxNumber = ""
        newTimeoutG5T3T2Image.timeOutNumber = 30
        returnList.append(newTimeoutG5T3T2Image)
        rowNumber += 1
        
        // Timeouts Game 3A Team 1
        let newTimeoutG3AT1T1Image = TimeOutImage()
        newTimeoutG3AT1T1Image.rowNumber = rowNumber
        newTimeoutG3AT1T1Image.boxImageName = "boxleft"
        newTimeoutG3AT1T1Image.boxNumber = "1"
        newTimeoutG3AT1T1Image.timeOutNumber = 31
        returnList.append(newTimeoutG3AT1T1Image)
        rowNumber += 1

        let newTimeoutG3AT2T1Image = TimeOutImage()
        newTimeoutG3AT2T1Image.rowNumber = rowNumber
        newTimeoutG3AT2T1Image.boxImageName = "boxrightend"
        newTimeoutG3AT2T1Image.boxNumber = "2"
        newTimeoutG3AT2T1Image.timeOutNumber = 32
        returnList.append(newTimeoutG3AT2T1Image)
        rowNumber += 1

        let newTimeoutG3AT3T1Image = TimeOutImage()
        newTimeoutG3AT3T1Image.rowNumber = rowNumber
        newTimeoutG3AT3T1Image.boxImageName = "boxblank"
        newTimeoutG3AT3T1Image.boxNumber = ""
        newTimeoutG3AT3T1Image.timeOutNumber = 33
        returnList.append(newTimeoutG3AT3T1Image)
        rowNumber += 1
        
        // Timeouts Game 3A Team 2
        let newTimeoutG3AT1T2Image = TimeOutImage()
        newTimeoutG3AT1T2Image.rowNumber = rowNumber
        newTimeoutG3AT1T2Image.boxImageName = "boxleft"
        newTimeoutG3AT1T2Image.boxNumber = "1"
        newTimeoutG3AT1T2Image.timeOutNumber = 34
        returnList.append(newTimeoutG3AT1T2Image)
        rowNumber += 1

        let newTimeoutG3AT2T2Image = TimeOutImage()
        newTimeoutG3AT2T2Image.rowNumber = rowNumber
        newTimeoutG3AT2T2Image.boxImageName = "boxrightend"
        newTimeoutG3AT2T2Image.boxNumber = "2"
        newTimeoutG3AT2T2Image.timeOutNumber = 35
        returnList.append(newTimeoutG3AT2T2Image)
        rowNumber += 1

        let newTimeoutG3AT3T2Image = TimeOutImage()
        newTimeoutG3AT3T2Image.rowNumber = rowNumber
        newTimeoutG3AT3T2Image.boxImageName = "boxblank"
        newTimeoutG3AT3T2Image.boxNumber = ""
        newTimeoutG3AT3T2Image.timeOutNumber = 36
        returnList.append(newTimeoutG3AT3T2Image)
        rowNumber += 1
        
        return returnList
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
    
    
//    func deleteScoringImages() {
//        print("Starting deleteScoringImages() in RealmManager")
//        if let realm = realm {
//            do {
//                try realm.write {
//                    let matchToUse = realm.objects(Match.self)[0]
//                    realm.delete(matchToUse.images[0])
//                }
//            } catch {
//                print("Error deleting images in Realm Manager")
//            }
//        }
//    }
    
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

