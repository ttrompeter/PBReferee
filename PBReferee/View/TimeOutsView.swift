//
//  TimoutsView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/12/22.
//

import RealmSwift
import SwiftUI

struct TimeOutsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var match: Match
    
    var body: some View {
        
        TabView {
            RegularTimeOutView(match: match)
                .tabItem {
                    Label("Regular", systemImage: "hourglass")
                }
            MedicalTimeOutView(match: match)
                .tabItem {
                    Label("Medical", systemImage: "cross")
                }
            RefereeTimeOutView(match: match)
                .tabItem {
                    Label("Referee", systemImage: "person.badge.clock")
                }
        }
    }
}

struct TimoutsView_Previews: PreviewProvider {
    static var previews: some View {
        TimeOutsView(match: Match())
    }
}

