//
//  Violation.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/7/22.
//

import RealmSwift
import SwiftUI

class Violation: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var playerNumber = 0
    @Persisted var isWarning = true
    @Persisted var violationDescription = ""
    @Persisted var gameNumber = 0
    @Persisted var violation = 1
    
    @Persisted(originProperty: "violations") var match: LinkingObjects<Match>
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum violationEnum: String {
        case breakingball
        case cursing
        case excessivearguing
        case excessivequestioning
        case excessiveappeals
        case strikingtheball
        case toomuchtime
        case threats
        case throwingpaddle
        case otherbehavior
    }
    
}

