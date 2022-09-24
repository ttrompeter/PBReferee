//
//  DataLoadView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/30/22.
//

import RealmSwift
import SwiftUI

struct DataLoadView: View {
    
    @Environment(\.realm) var realm
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @EnvironmentObject var sheetManager: SheetManager

    @State private var isShowHomeOpenMatch = false
    @State private var isShowHomeNewMatch = false
    @State private var newMatch = Match()
    @State private var openMatch = Match()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(width: CGFloat(660), height: CGFloat(410))
                    .foregroundColor(Constants.CLOUDS)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                VStack {
                    HStack (spacing: 40) {
                        
                        //NavigationLink(value: <#T##(Decodable & Encodable & Hashable)?#>, label: <#T##() -> _#>)
                        //NavigationLink(<#T##title: StringProtocol##StringProtocol#>, value: <#T##(Decodable & Encodable & Hashable)?#>)
                        
                        
                        NavigationLink(destination: HomeView(match: openMatch).environmentObject(sheetManager).environmentObject(scoresheetManager).environmentObject(realmManager), isActive: $isShowHomeOpenMatch) { }
                        
                        NavigationLink(destination: HomeView(match: newMatch).environmentObject(sheetManager).environmentObject(scoresheetManager).environmentObject(realmManager), isActive: $isShowHomeNewMatch) { }
                    }
                }
            }  // End ZStack
            .onAppear {
                // Check Realm DB to see there are settings in the database. If no settings are in database, then add one.
                let existingSettings = realm.objects(Settings.self)
                if existingSettings.count < 1 {
                    realmManager.createNewSettings()
                }
                // Open existing unfinished match if there is one, otherwise create a new match an use it.
                if let unfinishedMatch = realm.objects(Match.self).where({$0.isCompleted == false}).first {
                    $openMatch.wrappedValue = unfinishedMatch
                    isShowHomeOpenMatch.toggle()
                    print("Using existing match in DataLoadView: \(openMatch.eventTitle)")
                } else {
                    
                    // TODO: - This is just for development - change for production
                    //newMatch = realmManager.createNewMatch()
                    newMatch = realmManager.createNewDevelopmentMatch()
                    isShowHomeNewMatch = true
                    print("Using new match in DataLoadView: \(newMatch.eventTitle)")
                }
            }
        }  // End NavigationView
        //.navigationViewStyle(.stack)
        .statusBar(hidden: true)
    }
}

//struct DataLoadView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataLoadView()
//    }
//}


