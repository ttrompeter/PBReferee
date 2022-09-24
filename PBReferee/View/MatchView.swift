//
//  MatchView.swift
//  PBReferee
//
//  Created by Tom Trompeter on 9/24/22.
//

import RealmSwift
import SwiftUI

struct MatchView: View {
    
    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    //@EnvironmentObject var sheetManager: SheetManager
    @ObservedRealmObject var match: Match
    
    
    
    var body: some View {
        Text("Match View")
    }
}


