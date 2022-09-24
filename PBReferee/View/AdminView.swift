//
//  MapView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

struct AdminView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var match: Match
    
    var body: some View {
        
        TabView {
            ScoresheetAdminView(match: match)
                .tabItem {
                    Label("Scoresheet", systemImage: "camera.fill")
                }
            SettingsAdminView(match: match)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            StatisticsAdminView(match: match)
                .tabItem {
                    Label("Statistics", systemImage: "list.bullet.rectangle.fill")
                }
            ArchivedMatchesListView()
                .tabItem {
                    Label("Archive", systemImage: "externaldrive.fill")
                }
            UserManualView()
                .tabItem {
                    Label("User Manual", systemImage: "character.book.closed")
                }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminView()
//    }
//}

