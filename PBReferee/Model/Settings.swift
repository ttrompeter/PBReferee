//
//  Settings.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/3/22.
//
import RealmSwift
import Foundation

class Settings: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var defaultEmailAddress = ""
    @Persisted var defaultEventTitle = ""
    @Persisted var defaultLocation = ""
    // TODO: - For production this needs to be defaultRefereeName = ""
    @Persisted var defaultRefereeName = "Rufus Artman"
    @Persisted var defaultUserEmailAddress = "ttrompeter@zoho.com"
    @Persisted var isShowWelcomeScreen = true
    @Persisted var numberOfTimeoutsPerGame = 2
    @Persisted var numberOfViolationsPerGame = 2
    @Persisted var numberOfViolationsPerMatch = 3
    // Play Style (selectedDoublesPlay) Options: 1 - Singles, 2 - Doubles
    @Persisted var selectedDoublesPlay = 2
    // Match Format Options: 1 - Single Game, 2 - 2 of 3 Games, 3 - 3 of 5 Games
    @Persisted var selectedMatchFormat = 2
    // PointsToWin Options: 7 Points, 11 Points, 15 Points, 21 Points
    @Persisted var selectedPointsToWin = 11
    // Scoring Format Options 1 - Regular Scoring, 2 - Rally Scoring
    @Persisted var selectedScoringFormat = 1
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

