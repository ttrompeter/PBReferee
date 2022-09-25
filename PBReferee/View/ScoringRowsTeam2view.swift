//
//  ScoringRowsTeam2View.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/21/22.
//

import RealmSwift
import SwiftUI

struct ScoringRowsTeam2View: View {
    
    @ObservedRealmObject var match: Match
    
    @State private var matchFormat = 2
    @State private var showSideOutImage1 = false
    @State private var isSecondServer = false
    @State private var pointNumber = 0
    @State private var gameNumber = 1
    @State private var scoreTm1 = 0
    @State private var scoreTm2 = 0
    
    @State private var servers1Tm1NameEvenRow = "X"
    @State private var servers1Tm1NameOddRow = "Ellen"
    @State private var servers2Tm2NameEvenRow = "Rufus"
    @State private var servers2Tm2NameOddRow = "X"

    
//    @State private var scoreImagesRow6 = [
//        ScoreImage(boxImageName: "boxleft", boxNumber: 1),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 2),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 3),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 4),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 5),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 6),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 7),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 8),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 9),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 10),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 11),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 12),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 13),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 14),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 15),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 16),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 17),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 18),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 19),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 20),
//        ScoreImage(boxImageName: "boxrightend", boxNumber: 21)
//    ]
//
//    @State private var scoreImagesRow7 = [
//        ScoreImage(boxImageName: "boxleft", boxNumber: 1),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 2),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 3),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 4),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 5),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 6),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 7),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 8),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 9),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 10),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 11),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 12),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 13),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 14),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 15),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 16),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 17),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 18),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 19),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 20),
//        ScoreImage(boxImageName: "boxrightend", boxNumber: 21)
//    ]
//
//    @State private var scoreImagesRow8 = [
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 1),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 2),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 3),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 4),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 5),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 6),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 7),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 8),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 9),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 10),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 11),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 12),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 13),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 14),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 15),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 16),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 17),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 18),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 19),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 20),
//        ScoreImage(boxImageName: "box", boxNumber: 21)
//    ]
//
//    @State private var scoreImagesRow8A = [
//        ScoreImage(boxImageName: "boxleft", boxNumber: 1),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 2),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 3),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 4),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 5),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 6),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 7),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 8),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 9),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 10),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 11),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 12),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 13),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 14),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 15),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 16),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 17),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 18),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 19),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 20),
//        ScoreImage(boxImageName: "boxrightend", boxNumber: 21)
//    ]
//
//    @State private var scoreImagesRow9 = [
//        ScoreImage(boxImageName: "boxleft", boxNumber: 1),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 2),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 3),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 4),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 5),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 6),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 7),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 8),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 9),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 10),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 11),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 12),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 13),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 14),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 15),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 16),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 17),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 18),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 19),
//        ScoreImage(boxImageName: "boxleft", boxNumber: 20),
//        ScoreImage(boxImageName: "boxrightend", boxNumber: 21)
//    ]
//
//    @State private var scoreImagesRow10 = [
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 1),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 2),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 3),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 4),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 5),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 6),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 7),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 8),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 9),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 10),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 11),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 12),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 13),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 14),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 15),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 16),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 17),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 18),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 19),
//        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 20),
//        ScoreImage(boxImageName: "box", boxNumber: 21)
//    ]
//
//    @State private var timeouts2ImagesRow6 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "2", isShowScore: false, score: "2/5"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
//    ]
//
//    @State private var timeouts2ImagesRow7 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "2", isShowScore: false, score: "2/5"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
//    ]
//
//    @State private var timeouts2ImagesRow8 = [
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "box", boxNumber: "2", isShowScore: false, score: "2/5"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
//    ]
//
//    @State private var timeouts2ImagesRow8A = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "2", isShowScore: false, score: "2/5"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
//    ]
//
//    @State private var timeouts2ImagesRow9 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "2", isShowScore: false, score: "2/5"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
//    ]
//
//    @State private var timeouts2ImagesRow10 = [
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "box", boxNumber: "2", isShowScore: false, score: "2/5"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
//    ]
//
//    @State private var timeouts3ImagesRow6 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "2", isShowScore: false, score: "4/3"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "3", isShowScore: false, score: "2/5")
//    ]
//
//    @State private var timeouts3ImagesRow7 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "2", isShowScore: false, score: "4/3"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "3", isShowScore: false, score: "2/5")
//    ]
//
//    @State private var timeouts3ImagesRow8 = [
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "2", isShowScore: false, score: "4/3"),
//        TimeoutImageX(boxImageName: "box", boxNumber: "3", isShowScore: false, score: "2/5")
//    ]
//
//    @State private var timeouts3ImagesRow8A = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "2", isShowScore: false, score: "4/3"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "3", isShowScore: false, score: "2/5")
//    ]
//
//    @State private var timeouts3ImagesRow9 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "2", isShowScore: false, score: "4/3"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "3", isShowScore: false, score: "2/5")
//    ]
//
//    @State private var timeouts3ImagesRow10 = [
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "1", isShowScore: false, score: "1/6"),
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "2", isShowScore: false, score: "4/3"),
//        TimeoutImageX(boxImageName: "box", boxNumber: "3", isShowScore: false, score: "2/5")
//    ]
    
    var body: some View {
        
        
        Grid(alignment: .topLeading, horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                ZStack {
                    Image("serverrectangletop")
                        .resizable()
                        .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION)
                    Text(servers1Tm1NameOddRow)
                        .font(.callout)
                        .foregroundColor(.secondary).opacity(0.8)
                }
                Image("boxblank")
                    .resizable()
                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                
                // Game 1 row of points
                //  Index values in realm are 105 - 125
                ForEach(105..<126) { index in
                    ZStack {
                        Image("\(match.points[index].boxImageName)")
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        
                        if match.points[index].isShowSideOut {
                            Image(match.points[index].sideOutImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        }
                        Text("\(match.points[index].boxNumber)")
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                }
                
                Image("boxblank")
                    .resizable()
                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                
                // Game 1 row of tdimeouts
                ForEach(15..<18) { index in
                    ZStack {
                        Image(match.timeouts[index].boxImageName)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        if match.timeouts[index].isShowScore {
                            Image(match.timeouts[index].score)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        }
                        Text(match.timeouts[index].boxNumber)
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                }
            }
            GridRow {
                ZStack {
                    Image("serverrectangletop")
                        .resizable()
                        .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION)
                    Text(servers1Tm1NameEvenRow)
                        .font(.callout)
                        .foregroundColor(.secondary).opacity(0.8)
                }
                Image("boxblank")
                    .resizable()
                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                
                // Game 2 row of points
                // index values in realm are 126 - 146
                ForEach(126..<147) { index in
                    ZStack {
                        Image("\(match.points[index].boxImageName)")
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        
                        if match.points[index].isShowSideOut {
                            Image(match.points[index].sideOutImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        }
                        Text("\(match.points[index].boxNumber)")
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                }
                
                Image("boxblank")
                    .resizable()
                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                
                ForEach(18..<21) { index in
                    ZStack {
                        Image(match.timeouts[index].boxImageName)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        if match.timeouts[index].isShowScore {
                            Image(match.timeouts[index].score)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        }
                        Text(match.timeouts[index].boxNumber)
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                }
            }
            if matchFormat == 2 {
                GridRow {
                    ZStack {
                        Image("serverrectanglefull")
                            .resizable()
                            .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION)
                        Text(servers1Tm1NameOddRow)
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    // Game 3 row of points
                    // index values in realm are 147 - 167
                    ForEach(147..<168) { index in
                        ZStack {
                            Image("\(match.points[index].boxImageName)")
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            
                            if match.points[index].isShowSideOut {
                                Image(match.points[index].sideOutImageName)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text("\(match.points[index].boxNumber)")
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                    
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    ForEach(21..<24) { index in
                        ZStack {
                            Image(match.timeouts[index].boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if match.timeouts[index].isShowScore {
                                Image(match.timeouts[index].score)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(match.timeouts[index].boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                }
            }
            if matchFormat == 3 {
                GridRow {
                    ZStack {
                        Image("serverrectangletop")
                            .resizable()
                            .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION)
                        Text(servers1Tm1NameOddRow)
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    // Game 3A row of points
                    // index values in realm are 231 - 251
                    ForEach(231..<252) { index in
                        ZStack {
                            Image("\(match.points[index].boxImageName)")
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            
                            if match.points[index].isShowSideOut {
                                Image(match.points[index].sideOutImageName)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text("\(match.points[index].boxNumber)")
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                    
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    ForEach(33..<36) { index in
                        ZStack {
                            Image(match.timeouts[index].boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if match.timeouts[index].isShowScore {
                                Image(match.timeouts[index].score)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(match.timeouts[index].boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                }
                GridRow {
                    ZStack {
                        Image("serverrectangletop")
                            .resizable()
                            .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION)
                        Text(servers1Tm1NameEvenRow)
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    // Game 4 row of points
                    // index values in realm are 168 - 188
                    ForEach(168..<189) { index in
                        ZStack {
                            Image("\(match.points[index].boxImageName)")
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            
                            if match.points[index].isShowSideOut {
                                Image(match.points[index].sideOutImageName)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text("\(match.points[index].boxNumber)")
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                    
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    ForEach(24..<27) { index in
                        ZStack {
                            Image(match.timeouts[index].boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if match.timeouts[index].isShowScore {
                                Image(match.timeouts[index].score)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(match.timeouts[index].boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                }
                GridRow {
                    ZStack {
                        Image("serverrectanglefull")
                            .resizable()
                            .frame(width: (Constants.BOX_DIMENSION * 3), height: Constants.BOX_DIMENSION)
                        Text(servers1Tm1NameOddRow)
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    // Game 5 row of points
                    // index values in realm are 189 - 209
                    ForEach(189..<210) { index in
                        ZStack {
                            Image("\(match.points[index].boxImageName)")
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            
                            if match.points[index].isShowSideOut {
                                Image(match.points[index].sideOutImageName)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text("\(match.points[index].boxNumber)")
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                    
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    ForEach(27..<29) { index in
                        ZStack {
                            Image(match.timeouts[index].boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if match.timeouts[index].isShowScore {
                                Image(match.timeouts[index].score)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(match.timeouts[index].boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                }
            }
        }
    }
}



//struct ScoringRowsTeam2View_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoringRowsTeam1View()
//    }
//}


