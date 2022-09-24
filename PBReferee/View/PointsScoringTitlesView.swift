//
//  PointScoringTitlesView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

struct PointsScoringTitlesView: View {
    
    @ObservedRealmObject var match: Match
    @State private var boxDimension = CGFloat(30)
    
    var body: some View {
        
        VStack (spacing: 0) {
            HStack (alignment: .top, spacing: 0) {
             
                Rectangle()
                    //.stroke(Color.green, lineWidth: 2.0)
                    .foregroundColor(.white)
                    .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION, alignment: .leading)
                    .overlay(Text("Servers"))
                
                //Empty space column
                VStack (spacing: 0) {
                    Rectangle()
                        //.stroke(Color.yellow, lineWidth: 2.0)
                        .foregroundColor(.white)
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION, alignment: .leading)
                }
                
                Rectangle()
                    //.stroke(Color.indigo, lineWidth: 2.0)
                    .foregroundColor(.white)
                    .frame(width: (Constants.BOX_DIMENSION * 21), height: Constants.BOX_DIMENSION, alignment: .leading)
                    .overlay(Text("Points Scoring & Sideouts"))

                //Empty space column
                VStack (spacing: 0) {
                    Rectangle()
                        //.stroke(Color.yellow, lineWidth: 2.0)
                        .foregroundColor(.white)
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION, alignment: .leading)
                }
                
                
                // Timeouts
                Rectangle()
                    //.stroke(Color.pink, lineWidth: 2.0)
                    .foregroundColor(.white)
                    .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION, alignment: .leading)
                    .overlay(Text("Timeouts"))
                
//                if match.selectedMatchFormat == 3 {
//                    Rectangle()
//                        .stroke(Color.pink, lineWidth: 2.0)
//                        .foregroundColor(.white)
//                        .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION, alignment: .leading)
//                        .overlay(Text("Timeouts"))
//                } else {
//                    Rectangle()
//                        .stroke(Color.brown, lineWidth: 2.0)
//                        .foregroundColor(.white)
//                        .frame(width: (Constants.BOX_DIMENSION * 2), height: Constants.BOX_DIMENSION, alignment: .leading)
//                        .overlay(Text("Timeouts"))
//                }
                
            }
        }
    }
}

//struct PointScoringTitlesView_Previews: PreviewProvider {
//    static var previews: some View {
//        PointsScoringTitlesView()
//    }
//}

