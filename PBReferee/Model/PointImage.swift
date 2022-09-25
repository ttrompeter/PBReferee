//
//  PointImage.swift
//  PBReferee
//
//  Created by Tom Trompeter on 9/24/22.
//

import RealmSwift
import SwiftUI

class PointImage: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var rowNumber: Int = 0
    @Persisted var boxImageName: String
    @Persisted var boxNumber: Int
    @Persisted var isShowSideOut: Bool = false
    @Persisted var pointNumber: Int
    @Persisted var sideOutImageName: String = "sideoutright"

    //@Persisted(originProperty: "points") var game: LinkingObjects<Game>
    @Persisted(originProperty: "points") var match: LinkingObjects<Match>
}
