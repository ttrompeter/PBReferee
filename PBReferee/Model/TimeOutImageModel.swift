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
    
}
