//
//  ArchivedMatchRowView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/10/22.
//

import RealmSwift
import SwiftUI

struct ArchivedMatchRowView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var archivedMatch: ArchivedMatch
    @State private var isShowArhivedMatch = false
    
    var body: some View {
        
        HStack {
            Button {
                isShowArhivedMatch.toggle()
            } label: {
                HStack {
                    VStack (alignment: .leading) {
                    Text("\(archivedMatch.namePlayer1Team1) | \(archivedMatch.namePlayer2Team1)")
                        .font(.headline)
                        .foregroundColor(Constants.MINT_LEAF)
                    Text("\(archivedMatch.namePlayer1Team2) | \(archivedMatch.namePlayer2Team2)")
                        .font(.headline)
                        .foregroundColor(Constants.MINT_LEAF)
                    Text("\(archivedMatch.eventTitle)        Match: \(archivedMatch.matchNumber)")
                        .font(.callout)
                        .foregroundColor(Constants.DARK_SLATE)
                        .lineLimit(1)
                        HStack {
                            Text("\(archivedMatch.matchDate, style: .date)")
                                .font(.caption)
                                .foregroundColor(Constants.DARK_SLATE)
                            Text("\(archivedMatch.matchDate, style: .time)")
                                .font(.caption)
                                .foregroundColor(Constants.DARK_SLATE)
                        }
                    }
                    Spacer()
                }
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $isShowArhivedMatch) { ArchivedMatchView(archivedMatch: archivedMatch).environmentObject(scoresheetManager) }
        }
    }
}

struct ArchivedMatchRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedMatchRowView(archivedMatch: ArchivedMatch())
    }
}

