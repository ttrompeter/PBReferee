//
//  ChangeMarkSideView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/2/22.
//

import RealmSwift
import SwiftUI

struct ChangeSidesTeam2View: View {
    
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var match: Match
    
    var body: some View {
        VStack(spacing: 0) {
            HStack (alignment: .top, spacing: 0) {
                
                // Servers listing display
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION, alignment: .leading)
                    Text(match.specialTeam2)
                        .font(.subheadline)
                        .foregroundColor(Constants.MINT_LEAF)
                }
                
                //Empty space column
                VStack (spacing: 0) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION, alignment: .leading)
                }
                
                Group {
                    Image(Constants.BOX_BLANK)  //1
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //2
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    if match.selectedPointsToWin == 7 {
                        Image(Constants.TRIANGLE)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    } else {
                        Image(Constants.BOX_BLANK)  //3
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    }
                    
                    Image(Constants.BOX_BLANK)  //4
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //5
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    if match.selectedPointsToWin == 11 {
                        Image(Constants.TRIANGLE)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    } else {
                        Image(Constants.BOX_BLANK)  //6
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    }
                    
                    Image(Constants.BOX_BLANK)  //7
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    if match.selectedPointsToWin == 15 {
                        Image(Constants.TRIANGLE)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    } else {
                        Image(Constants.BOX_BLANK)  //8
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    }
                    
                    Image(Constants.BOX_BLANK)  //9
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                }
                Group {
                    Image(Constants.BOX_BLANK)  //10
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    if match.selectedPointsToWin == 21 {
                        Image(Constants.TRIANGLE)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    } else {
                        Image(Constants.BOX_BLANK)  //11
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    }
                    
                    Image(Constants.BOX_BLANK)  //12
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //13
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //14
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //15
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //16
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //17
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //18
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //19
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                }
                
                Group {
                    Image(Constants.BOX_BLANK)  //20
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    Image(Constants.BOX_BLANK)  //21
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                }
                //Empty space column
                VStack (spacing: 0) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION, alignment: .leading)
                }
                // Timeouts Area
                if match.isShowViolation1Tm2 {
                    ZStack {
                        Image(Constants.BOX_BLANK)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        Image("red_yellow_cards")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                } else {
                    ZStack {
                        Image(Constants.BOX_BLANK)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    }
                }
                if match.isShowViolation2Tm2 {
                    ZStack {
                        Image(Constants.BOX_BLANK)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        Image("red_yellow_cards")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                } else {
                    ZStack {
                        Image(Constants.BOX_BLANK)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    }
                }
                if match.isShowViolation3Tm2 {
                    ZStack {
                        Image(Constants.BOX_BLANK)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        Image("red_yellow_cards")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                } else {
                    ZStack {
                        Image(Constants.BOX_BLANK)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    }
                }
            }
        }
    }
}

struct ChangeSidesMarkSideView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeSidesTeam2View(match: Match())
    }
}

