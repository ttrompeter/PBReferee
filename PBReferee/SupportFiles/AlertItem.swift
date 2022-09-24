//
//  AlertItem.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/6/22.
//

import SwiftUI


struct AlertItem: Identifiable {
    var id = UUID()
    var title = Text("")
    var message: Text?
    var dismissButton: Alert.Button?
    var primaryButton: Alert.Button?
    var secondaryButton: Alert.Button?
}

