//
//  Archive.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/26/22.
//

import RealmSwift
import SwiftUI

class Archive: Object, ObjectKeyIdentifiable {
    /*
     Saving information on last 10 matches to archive so can be recalled in App
     // Save location of image of match scorehsheet screenshot so image can be obtained
     // NOTE: Currently only the last screenshot taken is saved to file in Match code
     // Save date of match so data can be orderd and sorted and updated so only last 10 matches are archived
     // Save actual Match and Game data so it can be recalled and manipulated if desired
     */
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var scoresheetMatch1Location = ""
    @Persisted var scoresheetMatch2Location = ""
    @Persisted var scoresheetMatch3Location = ""
    @Persisted var scoresheetMatch4Location = ""
    @Persisted var scoresheetMatch5Location = ""
    @Persisted var scoresheetMatch6Location = ""
    @Persisted var scoresheetMatch7Location = ""
    @Persisted var scoresheetMatch8Location = ""
    @Persisted var scoresheetMatch9Location = ""
    @Persisted var scoresheetMatch10Location = ""
    @Persisted var archivedMatch1MatchDate: Date?
    @Persisted var archivedMatch2MatchDate: Date?
    @Persisted var archivedMatch3MatchDate: Date?
    @Persisted var archivedMatch4MatchDate: Date?
    @Persisted var archivedMatch5MatchDate: Date?
    @Persisted var archivedMatch6MatchDate: Date?
    @Persisted var archivedMatch7MatchDate: Date?
    @Persisted var archivedMatch8MatchDate: Date?
    @Persisted var archivedMatch9MatchDate: Date?
    @Persisted var archivedMatch10MatchDate: Date?
    
    // How do these work? Not Realm Property Types (maybe Data?)
    //@Persisted var archivedMatch1: Match?
    //@Persisted var archivedGame1Match1: Game?
}

