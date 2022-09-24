//
//  ScoringSectionTeam2View.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

struct ScoringSectionTeam2View: View {
    
    @ObservedRealmObject var match: Match
    
    var body: some View {
        
        HStack (alignment: .top, spacing: 0) {
            VStack (spacing: 0) {
                PointsScoringTitlesView(match: match)
                ScoringRowsTeam2View()
                ChangeSidesTeam2View(match: match)
                
                //                    PointsFirstRowTeam2View(match: match)
                //                    PointsSecondRowTeam2View(match: match)
                //                    PointsThirdRowTeam2View(match: match)
                //                    // If match is best 3 games of 5 games then show 5 games else just show 3 games
                //                    if match.selectedMatchFormat == 3 {
                //                        PointsFourthRowTeam2View(match: match)
                //                        PointsFifthRowTeam2View(match: match)
                //                    }
                
            }
        }
    }
}

struct ScoringSectionTeam2View_Previews: PreviewProvider {
    static var previews: some View {
        ScoringSectionTeam2View(match: Match())
    }
}

