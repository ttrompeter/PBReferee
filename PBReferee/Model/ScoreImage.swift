//
//  ScoreImage.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/21/22.
//

import SwiftUI

struct ScoreImage: Identifiable, Equatable {
    
    var id = UUID()
    var boxImageName: String
    var boxNumber: Int
    var isShowSideOut: Bool = false
    var sideOutImageName: String = "sideoutright"
}

