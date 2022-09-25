//
//  TimeOutImageModel.swift
//  PBReferee
//
//  Created by Tom Trompeter on 9/25/22.
//

import RealmSwift
import SwiftUI

class TimeOutImageModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var rowNumber: Int = 0
    @Persisted var boxImageName: String
    @Persisted var boxNumber: String = ""
    @Persisted var timeOutNumber: Int
    @Persisted var isShowScore: Bool = false
    @Persisted var score: String = "0/0"
    
    //@Persisted(originProperty: "timeouts") var match: LinkingObjects<Match>
}
