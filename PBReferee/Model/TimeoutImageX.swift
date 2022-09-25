//
//  TimeoutImageX.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/21/22.
//

import SwiftUI

struct TimeoutImageX: Identifiable, Equatable {
    
    var id = UUID()
    var boxImageName: String
    var boxNumber: String
    var isShowScore: Bool = false
    var score: String = "0/0"
}

