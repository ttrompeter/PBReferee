//
//  IntroductionView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/19/22.
//

import RealmSwift
import SwiftUI

struct IntroductionView: View {
    
    @ObservedRealmObject var match: Match
    @State private var isStartApp = false
    
    var body: some View {
        
        TabView {
            IntroductionOverviewView(match: match)
                .tabItem {
                    Label("Overview", systemImage: "eyeglasses")
                }
            QuickstartView(match: match)
                .tabItem {
                    Label("Quickstart", systemImage: "text.magnifyingglass")
                }
            ScorekeepingView(match: match)
                .tabItem {
                    Label("Scorekeeping", systemImage: "list.bullet.rectqangle.portrait")
                }
        }
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView(match: Match())
    }
}

