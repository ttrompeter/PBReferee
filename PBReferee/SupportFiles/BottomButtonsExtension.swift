//
//  BottomButtonsExtension.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/3/22.
//

import RealmSwift
import Foundation

extension BottomButtonsView {

    func setupNewDevelopmentMatch() {
        print("Starting setupNewDevelopmentMatch in BottomButtonsViewExtension")
        
        // TODO: - This is just seed data for development - delete in production
        let EventNamesArray = ["Solana Beach Summer Games","Jamul Pickleball Jamboree","Monterey Seniors Tournament","Pickleball In Pasadena","San Jose Regionals","Mountain View Invitational Tournament","San Francisco By The Bay Open Championship","Vancouver Friendly Round Robin","Victorville Regional Fun Games","Yuma Winter Festival GAmes","Las Vegas Seniors Open Championship","Portland Western Open Games","Salt Lake City Tournament","Reno City Championship","Huntington Beach Regional Tournament","Santa Maria Round  Robin Matches","Twentynine Palms Hot Games","Thousand Oaks Senior Championship","San Dismas Pickleball Round Robin","Sausalito Fun Games","Solvang Danish Open","Venice All-Ages Championships","Vista Senior Players Championship","Temecula Pickleball Matches","Santa Clarita Regional Open Games","Swami's Pickleball Round Robin Matches","Santa Barbara Regional Championship","Melba Bishop Fun Games","Big Sur West Coast Championship","Big Bear Lake Open Championship","Carmel-By-The-Sea Pickleball Championship","Coronado Senior Fun Games","Del Mar Round Robin Games","Fish Camp Senior Open Championship","Half Moon Bay Pickleball Invitational","Hermosa Beach All-Ages Invitational","Julian Pickleball Jamboree","Lost Hills Regional Open","Manhattan Beach Junior Championships","Milpitas Memorial Open","Nipton World Invitational","Ojai Pickleball Championships","Port Hueneme Pickleball Open Championships","Petaluma Pickleball Fun Games","Rancho Palos Verdes Pickleball Masters Tournament"]
        
        let PlayerNamesArray = ["Abigal Adams", "Samuel Chase", "John Jay", "Harriet Stowe", "Thomas Johnson", "William Rhenquist", "James Iredall", "Elizabeth Stanton", "John Rutledge", "Benjamin Curtis", "Oliver Ellsworth", "Susan Anthony", "William Cushing", "Bushrod Washington", "John Archibald", "James Wilson", "John Blair", "Antonin Scalia", "William Paterson", "Alfred Moore", "Harriet Tubman", "John Marshall", "William Johnson", "Henry Livingston", "Thomas Todd", "Gabriel Duvall", "Joseph Story", "Clara Barton", "Smith Thompson", "Robert Trimble", "Emily Dickinson", "Louisa Alcott", "Gail Laughlin", "Georgia O'Keeffe", "Margaret Smith", "Roger Taney", "John McLean", "Margaret Mead", "Henry Baldwin", "Mildred Zaharias", "James Wayne", "Jane Godall", "Phillip Barbour", "Barbara Jordan", "John Catron", "Mia Hamm", "John McKinley", "Chloe Kim", "Peter Daniel", "Kathrine Johnson", "Samuel Nelson", "Margaret Bourke-White", "Levi Woodbury", "Valentina Tereshkova", "Robert Grier", "Misty Copeland", "John Campbell", "Ester Ledecka", "Nathan Clifford", "Naomi Osaka", "Noah Swayne", "Ibtihaj Muhammad", "Samuel Miller", "Laverne Cox", "David Davis", "Shonda Rhimes", "Stephen Field", "Ariana Grande", "Mindy Kaling", "William Strong", "Marie Kondo", "Joseph Bradley", "Julie Taymor", "Ashley Graham", "Ruth Ginsburg", "Ward Hunt", "Morrison Waite", "John Harlan", "William Woods", "Stanley Mathews", "Horace Gray", "Hypatia Alexandria", "Elena Piscopia", "Samuel Blatchford", "Naria Agnesi", "Lucius Lamar", "Sophie Germain", "Melville Fuller", "Mary Sommerville", "Ada Lovelace", "David Brewer", "Charlotte Scott", "Henry Brown", "Sofia Kovalevskaya", "George Shiras", "Alicia Stott", "Howell Jackson", "Amalie Noether", "Edward White", "Mary Walker", "Rufus Peckham", "Edith Wharton", "Joseph McKenna", "Dorthy Levitt", "Oliver Holmes", "Sarah Breedlove", "William Day", "Jeannette Rankin", "William Moody", "Margaret Sanger", "Horace Lurton", "Jane Addams", "Charles Hughes", "Gwendolyn Brooks", "Edward White", "Elizabeth Eckford", "Willis Devanter", "Junko Tabei", "Joseph Lamar", "Sally Ride", "Mahlon Pitney", "Ann Dunwoody", "James McReynolds", "Mae Jamison", "John Clarke", "William Taft", "Frida Kahlo", "George Sutherland", "Rita Moreno", "Pierce Butler", "Maria Salinas", "Edward Sanford", "Demi Lovato", "Harlan Stone", "Dara Torres", "Charles Hughes", "Zhou Qunfei", "Owen Roberts", "Harlan Stone", "Hugo Black", "Stanley Reed", "Selena Quintanilla", "William Douglas", "Frank Murphy", "Francoise Meyers", "James Byrne", "Robert Jackson", "Maria Moraes", "Maria Fissolo", "Jacqueline Mars", "Wiley Rutledge", "Harold Burton", "Fred Vinson", "Tom Clark", "Sherman Minton"]
        
        let LocationArray = ["Carol's Court At Oceana", "Poinsetta Park Tennis & Pickleball Courts", "Pickleball Club of Carlsbad", "Bobby Riggs Racket & Paddle Center", "Melba Bishop Recreation Center", "Calavera Community Center", "Brengle Terrace Park", "St. Michaels By-the-Sea Pickleball", "Cottonwood Creek Park", "Carmel Valley Recreation Center", "Pacific Highlands Ranch", "Altamira 4 Tennis & Pickleball", "Ocean Air Recreational Center", "Pacific Beach Tennis Club", "Boogard's Pickleball Ranch", "Big Rock Park", "MackenzieCreek Park", "Cypress Canyon Park", "Del Cerro Tennis Club", "Colina Del Sol Park", "Pine Avenue Community Center", "Stagecoach Community Center", "Junior Seau Community Center", "Ocean Hills Country Club", "Thibodo Park", "Lomas Santa Fe Country Club", "Glassman Recreation Center", "Innovation Park", "Meadows Park", "French Park", "Barnes Tennis Center", "Ocean Beach Recreation Center", "Olive Grove Park"]
        
        
        $match.eventTitle.wrappedValue = EventNamesArray[Int.random(in: 1..<EventNamesArray.count)]
        $match.matchLocation.wrappedValue = LocationArray[Int.random(in: 1..<LocationArray.count)]
        
        $match.namePlayer1Team1.wrappedValue = PlayerNamesArray[Int.random(in: 1..<PlayerNamesArray.count)]          // Should be ""
        $match.namePlayer2Team1.wrappedValue = PlayerNamesArray[Int.random(in: 1..<PlayerNamesArray.count)]          // Should be ""
        $match.namePlayer1Team2.wrappedValue = PlayerNamesArray[Int.random(in: 1..<PlayerNamesArray.count)]          // Should be ""
        $match.namePlayer2Team2.wrappedValue = PlayerNamesArray[Int.random(in: 1..<PlayerNamesArray.count)]          // Should be ""
        
        $match.courtNumber.wrappedValue = ""
        $match.currentGameArrayIndex.wrappedValue = 0
        $match.currentGameNumber.wrappedValue = 1
        $match.emailAddressForScoresheetSnaphot.wrappedValue = realm.objects(Settings.self)[0].defaultEmailAddress
        $match.firstServerDesignationGame1Team1.wrappedValue = "\(match.player1FirstName)"          // Default is ""
        $match.firstServerDesignationGame2Team1.wrappedValue = "X"                                  // Default is ""
        $match.firstServerDesignationGame3Team1.wrappedValue = "\(match.player1FirstName)"          // Default is ""
        $match.firstServerDesignationGame4Team1.wrappedValue = "X"                                  // Default is ""
        $match.firstServerDesignationGame5Team1.wrappedValue = "\(match.player1FirstName)"          // Default is ""
        $match.firstServerDesignationGame1Team2.wrappedValue = "X"                                  // Default is ""
        $match.firstServerDesignationGame2Team2.wrappedValue = "\(match.player3FirstName)"          // Default is ""
        $match.firstServerDesignationGame3Team2.wrappedValue = "X"                                  // Default is ""
        $match.firstServerDesignationGame4Team2.wrappedValue = "\(match.player3FirstName)"          // Default is ""
        $match.firstServerDesignationGame5Team2.wrappedValue = "X"                                  // Default is ""
        $match.isCompleted.wrappedValue = false
        $match.isForfeitMatch.wrappedValue = false
        $match.isMatchSetupCompleted.wrappedValue = true                              // Default is false
        $match.isMatchStarted.wrappedValue = false
        $match.isSecondServer.wrappedValue = true
        $match.isServerSideSet.wrappedValue = true                                    // Default is false
        $match.isServingLeftSide.wrappedValue = false
        $match.isTeam1Serving.wrappedValue = true
        $match.isShowViolation1Tm1.wrappedValue = false
        $match.isShowViolation2Tm1.wrappedValue = false
        $match.isShowViolation3Tm1.wrappedValue = false
        $match.isShowViolation1Tm2.wrappedValue = false
        $match.isShowViolation2Tm2.wrappedValue = false
        $match.isShowViolation3Tm2.wrappedValue = false
        $match.matchDate.wrappedValue = Date.now
        $match.matchDuration.wrappedValue = 0.0
        $match.matchEndDateValue.wrappedValue = Date.now
        $match.matchFinalGameScores.wrappedValue = ""
        $match.matchFinalScore.wrappedValue = ""
        $match.matchLoser.wrappedValue = ""
        $match.matchNotes.wrappedValue = ""
        $match.matchNumber.wrappedValue = "1"                                          // Default is "0"
        $match.matchRefereeRemarks.wrappedValue = "Water breaks every 30 minutes"      // Default is ""
        $match.matchStartDateValue.wrappedValue = Calendar.current.date(byAdding: .minute, value: -17, to: Date())!// Default is Date.now
        $match.matchStartingServerName.wrappedValue = "Undetermined"
        $match.matchStartingServerNumber.wrappedValue = 1                              // Default is 0
        $match.matchWinner.wrappedValue = ""
        $match.matchWinningTeam.wrappedValue = 0
        $match.numberOfTimeoutsPerGame.wrappedValue = 2
        $match.player1Team1Identifiers.wrappedValue = "Red Hat"                        // Default is ""
        $match.player2Team1Identifiers.wrappedValue = "Blue Shorts"                    // Default is ""
        $match.player1Team2Identifiers.wrappedValue = "Blonds"                         // Default is ""
        $match.player2Team2Identifiers.wrappedValue = "Yellow Shoes"                   // Default is ""
        $match.scoreDisplay.wrappedValue = "0 - 0 - 2"
        $match.selectedDoublesPlay.wrappedValue = 2
        $match.selectedMatchFormat.wrappedValue = 1                                    // Default is 2
        $match.selectedPointsToWin.wrappedValue = 7                                    // Default is 11
        $match.selectedScoringFormat.wrappedValue = 1
        $match.servingPlayerNumber.wrappedValue = 1                                    // Default is 0
        $match.specialTeam1.wrappedValue = ""
        $match.specialTeam2.wrappedValue = ""
        $match.teamTakingTimeout.wrappedValue = 0
        $match.whoIsServingText.wrappedValue = "2nd Server"
        
        realmManager.deleteGames()
        realmManager.addNewDevelopmentGames()
        //realmManager.deleteScoringImages()
        //realmManager.addNewScoringImages()
        realmManager.deleteViolations()
        
        // Reset the scoresheetManager variables to default values
        scoresheetManager.isDefaultRefereeNameSet = false
        scoresheetManager.isGameFirstServerSet = false
        scoresheetManager.isGameStarted = false
        scoresheetManager.isGameStartReady = true                     // Should be false for default
        scoresheetManager.isGameWinner = false
        scoresheetManager.isNewGameCreated = false
        scoresheetManager.isNewMatchCreated = false
        scoresheetManager.isMatchStartingServerSet = true             // Shoud be false for default
        scoresheetManager.isMatchWinner = false
        scoresheetManager.isScreenOrientationCorrect = true           // Should be false for default
        scoresheetManager.isShowMatchSetup = false
        scoresheetManager.isShowScoresheetImage = true
        scoresheetManager.isShowStatisticsAdminView = false
        scoresheetManager.isStartNewMatch = false
        scoresheetManager.isTimeOutTaken = false
        scoresheetManager.lastActionGameNumber = 0
        scoresheetManager.lastActionPlayerNumber = 0
        scoresheetManager.lastActionScore = 0
        scoresheetManager.player1FoulsCount = 0
        scoresheetManager.player2FoulsCount = 0
        scoresheetManager.player3FoulsCount = 0
        scoresheetManager.player4FoulsCount = 0
        scoresheetManager.player1WarningsCount = 0
        scoresheetManager.player2WarningsCount = 0
        scoresheetManager.player3WarningsCount = 0
        scoresheetManager.player4WarningsCount = 0
        scoresheetManager.playerInitials = ""
        scoresheetManager.presentInitialsAlert = false
        scoresheetManager.team1MatchStartingServerName = ""
        scoresheetManager.team2MatchStartingServerName = ""
    }
    
    func setupNewMatch() {
        let settings = realm.objects(Settings.self)[0]
        
        // Reset Match variables to default values
        $match.courtNumber.wrappedValue = ""
        $match.currentGameArrayIndex.wrappedValue = 0
        $match.currentGameNumber.wrappedValue = 1
        $match.emailAddressForScoresheetSnaphot.wrappedValue = realm.objects(Settings.self)[0].defaultEmailAddress
        $match.eventTitle.wrappedValue = settings.defaultEventTitle
        $match.firstServerDesignationGame1Team1.wrappedValue = ""
        $match.firstServerDesignationGame2Team1.wrappedValue = ""
        $match.firstServerDesignationGame3Team1.wrappedValue = ""
        $match.firstServerDesignationGame4Team1.wrappedValue = ""
        $match.firstServerDesignationGame5Team1.wrappedValue = ""
        $match.firstServerDesignationGame1Team2.wrappedValue = ""
        $match.firstServerDesignationGame2Team2.wrappedValue = ""
        $match.firstServerDesignationGame3Team2.wrappedValue = ""
        $match.firstServerDesignationGame5Team2.wrappedValue = ""
        $match.isCompleted.wrappedValue = false
        $match.isMatchSetupCompleted.wrappedValue = false
        $match.isMatchStarted.wrappedValue = false
        $match.isSecondServer.wrappedValue = true
        $match.isServerSideSet.wrappedValue = false
        $match.isServingLeftSide.wrappedValue = false
        $match.isTeam1Serving.wrappedValue = true
        $match.isShowViolation1Tm1.wrappedValue = false
        $match.isShowViolation2Tm1.wrappedValue = false
        $match.isShowViolation3Tm1.wrappedValue = false
        $match.isShowViolation1Tm2.wrappedValue = false
        $match.isShowViolation2Tm2.wrappedValue = false
        $match.isShowViolation3Tm2.wrappedValue = false
        $match.matchDate.wrappedValue = Date.now
        $match.matchDuration.wrappedValue = 0.0
        $match.matchEndDateValue.wrappedValue = Date.now
        $match.matchFinalGameScores.wrappedValue = ""
        $match.matchFinalScore.wrappedValue = ""
        $match.matchLocation.wrappedValue = settings.defaultLocation
        $match.matchLoser.wrappedValue = ""
        $match.matchNotes.wrappedValue = ""
        $match.matchNumber.wrappedValue = "0"
        $match.matchRefereeRemarks.wrappedValue = ""
        $match.matchStartDateValue.wrappedValue = Date.now
        $match.matchStartingServerName.wrappedValue = "Undetermined"
        $match.matchStartingServerNumber.wrappedValue = 0
        $match.matchWinner.wrappedValue = ""
        $match.matchWinningTeam.wrappedValue = 0
        $match.namePlayer1Team1.wrappedValue = ""
        $match.namePlayer2Team1.wrappedValue = ""
        $match.namePlayer1Team2.wrappedValue = ""
        $match.namePlayer2Team2.wrappedValue = ""
        $match.numberOfTimeoutsPerGame.wrappedValue = 2
        $match.player1Team1Identifiers.wrappedValue = ""
        $match.player2Team1Identifiers.wrappedValue = ""
        $match.player1Team2Identifiers.wrappedValue = ""
        $match.player2Team2Identifiers.wrappedValue = ""
        $match.scoreDisplay.wrappedValue = "0 - 0 - 2"
        $match.selectedDoublesPlay.wrappedValue = 2
        $match.selectedMatchFormat.wrappedValue = 2
        $match.selectedPointsToWin.wrappedValue = 11
        $match.selectedScoringFormat.wrappedValue = 1
        $match.servingPlayerNumber.wrappedValue = 0
        $match.specialTeam1.wrappedValue = ""
        $match.specialTeam2.wrappedValue = ""
        $match.teamTakingTimeout.wrappedValue = 0
        $match.whoIsServingText.wrappedValue = "2nd Server"

        realmManager.deleteGames()
        realmManager.addNewDevelopmentGames()
        //realmManager.deleteScoringImages()
        //realmManager.addNewScoringImages()
        realmManager.deleteViolations()

        // Reset the scoresheetManager variables to default values
        scoresheetManager.isDefaultRefereeNameSet = false
        scoresheetManager.isGameFirstServerSet = false
        scoresheetManager.isGameStarted = false
        scoresheetManager.isGameStartReady = true      // Should be false for default
        scoresheetManager.isGameWinner = false
        scoresheetManager.isNewGameCreated = false
        scoresheetManager.isNewMatchCreated = false
        scoresheetManager.isMatchStartingServerSet = true  // Shoud be false for default
        scoresheetManager.isMatchWinner = false
        scoresheetManager.isScreenOrientationCorrect = true  // Should be false for default
        scoresheetManager.isShowMatchSetup = false
        scoresheetManager.isShowScoresheetImage = true
        scoresheetManager.isShowStatisticsAdminView = false
        scoresheetManager.isStartNewMatch = false
        scoresheetManager.isTimeOutTaken = false
        scoresheetManager.lastActionGameNumber = 0
        scoresheetManager.lastActionPlayerNumber = 0
        scoresheetManager.lastActionScore = 0
        scoresheetManager.player1FoulsCount = 0
        scoresheetManager.player2FoulsCount = 0
        scoresheetManager.player3FoulsCount = 0
        scoresheetManager.player4FoulsCount = 0
        scoresheetManager.player1WarningsCount = 0
        scoresheetManager.player2WarningsCount = 0
        scoresheetManager.player3WarningsCount = 0
        scoresheetManager.player4WarningsCount = 0
        scoresheetManager.playerInitials = ""
        scoresheetManager.presentInitialsAlert = false
        scoresheetManager.team1MatchStartingServerName = ""
        scoresheetManager.team2MatchStartingServerName = ""
    }
    
     
}

