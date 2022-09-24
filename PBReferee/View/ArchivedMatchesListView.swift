//
//  ArchivedMatchesListView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/31/22.
//

import RealmSwift
import SwiftUI

struct ArchivedMatchesListView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedResults(ArchivedMatch.self) var archives
    @State private var isShowArhivedMatch = false
    
    var body: some View {
        
        VStack {
            Text("Pickleball Match Archives ")
                .bold()
                .padding()
                .font(.largeTitle)
                .foregroundColor(Constants.DARK_SLATE)
            NavigationView {
                VStack {
                    if archives.count < 1 {
                        Text("There are no archived Matches")
                            .font(.headline)
                            .foregroundColor(Constants.MINT_LEAF)
                    }
                    List {
                        ForEach(archives.sorted(byKeyPath: "matchDate", ascending: false)) { archivedMatch in
                            if !archivedMatch.isInvalidated {
                                ArchivedMatchRowView(archivedMatch: archivedMatch)
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    .listStyle(.plain)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }   // End NavigationView
            .navigationViewStyle(.stack)
            .statusBar(hidden: true)
            
            Spacer()
            HStack (spacing: 40) {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.vertical, 10)
        } // End Top VStak
    }
}

//struct ArchivedMathesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchivedMatchesListView()
//    }
//}

