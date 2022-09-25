//
//  ScoringRowsTeam1View.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/21/22.
//

import RealmSwift
import SwiftUI

struct ScoringRowsTeam1View: View {
    
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

 /*
  
    @State var scoreImagesRow1 = [
        ScoreImage(boxImageName: "boxleft", boxNumber: 1),
        ScoreImage(boxImageName: "boxleft", boxNumber: 2),
        ScoreImage(boxImageName: "boxleft", boxNumber: 3),
        ScoreImage(boxImageName: "boxleft", boxNumber: 4),
        ScoreImage(boxImageName: "boxleft", boxNumber: 5),
        ScoreImage(boxImageName: "boxleft", boxNumber: 6),
        ScoreImage(boxImageName: "boxleft", boxNumber: 7),
        ScoreImage(boxImageName: "boxleft", boxNumber: 8),
        ScoreImage(boxImageName: "boxleft", boxNumber: 9),
        ScoreImage(boxImageName: "boxleft", boxNumber: 10),
        ScoreImage(boxImageName: "boxleft", boxNumber: 11),
        ScoreImage(boxImageName: "boxleft", boxNumber: 12),
        ScoreImage(boxImageName: "boxleft", boxNumber: 13),
        ScoreImage(boxImageName: "boxleft", boxNumber: 14),
        ScoreImage(boxImageName: "boxleft", boxNumber: 15),
        ScoreImage(boxImageName: "boxleft", boxNumber: 16),
        ScoreImage(boxImageName: "boxleft", boxNumber: 17),
        ScoreImage(boxImageName: "boxleft", boxNumber: 18),
        ScoreImage(boxImageName: "boxleft", boxNumber: 19),
        ScoreImage(boxImageName: "boxleft", boxNumber: 20),
        ScoreImage(boxImageName: "boxrightend", boxNumber: 21)
    ]
    
    @State var scoreImagesRow2 = [
        
        ScoreImage(boxImageName: "boxleft", boxNumber: 1),
        ScoreImage(boxImageName: "boxleft", boxNumber: 2),
        ScoreImage(boxImageName: "boxleft", boxNumber: 3),
        ScoreImage(boxImageName: "boxleft", boxNumber: 4),
        ScoreImage(boxImageName: "boxleft", boxNumber: 5),
        ScoreImage(boxImageName: "boxleft", boxNumber: 6),
        ScoreImage(boxImageName: "boxleft", boxNumber: 7),
        ScoreImage(boxImageName: "boxleft", boxNumber: 8),
        ScoreImage(boxImageName: "boxleft", boxNumber: 9),
        ScoreImage(boxImageName: "boxleft", boxNumber: 10),
        ScoreImage(boxImageName: "boxleft", boxNumber: 11),
        ScoreImage(boxImageName: "boxleft", boxNumber: 12),
        ScoreImage(boxImageName: "boxleft", boxNumber: 13),
        ScoreImage(boxImageName: "boxleft", boxNumber: 14),
        ScoreImage(boxImageName: "boxleft", boxNumber: 15),
        ScoreImage(boxImageName: "boxleft", boxNumber: 16),
        ScoreImage(boxImageName: "boxleft", boxNumber: 17),
        ScoreImage(boxImageName: "boxleft", boxNumber: 18),
        ScoreImage(boxImageName: "boxleft", boxNumber: 19),
        ScoreImage(boxImageName: "boxleft", boxNumber: 20),
        ScoreImage(boxImageName: "boxrightend", boxNumber: 21)
    ]
    
    @State var scoreImagesRow3 = [
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 1),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 2),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 3),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 4),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 5),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 6),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 7),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 8),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 9),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 10),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 11),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 12),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 13),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 14),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 15),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 16),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 17),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 18),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 19),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 20),
        ScoreImage(boxImageName: "box", boxNumber: 21)
    ]
    
    @State var scoreImagesRow3A = [
        ScoreImage(boxImageName: "boxleft", boxNumber: 1),
        ScoreImage(boxImageName: "boxleft", boxNumber: 2),
        ScoreImage(boxImageName: "boxleft", boxNumber: 3),
        ScoreImage(boxImageName: "boxleft", boxNumber: 4),
        ScoreImage(boxImageName: "boxleft", boxNumber: 5),
        ScoreImage(boxImageName: "boxleft", boxNumber: 6),
        ScoreImage(boxImageName: "boxleft", boxNumber: 7),
        ScoreImage(boxImageName: "boxleft", boxNumber: 8),
        ScoreImage(boxImageName: "boxleft", boxNumber: 9),
        ScoreImage(boxImageName: "boxleft", boxNumber: 10),
        ScoreImage(boxImageName: "boxleft", boxNumber: 11),
        ScoreImage(boxImageName: "boxleft", boxNumber: 12),
        ScoreImage(boxImageName: "boxleft", boxNumber: 13),
        ScoreImage(boxImageName: "boxleft", boxNumber: 14),
        ScoreImage(boxImageName: "boxleft", boxNumber: 15),
        ScoreImage(boxImageName: "boxleft", boxNumber: 16),
        ScoreImage(boxImageName: "boxleft", boxNumber: 17),
        ScoreImage(boxImageName: "boxleft", boxNumber: 18),
        ScoreImage(boxImageName: "boxleft", boxNumber: 19),
        ScoreImage(boxImageName: "boxleft", boxNumber: 20),
        ScoreImage(boxImageName: "boxrightend", boxNumber: 21)
    ]
    
    @State var scoreImagesRow4 = [
        ScoreImage(boxImageName: "boxleft", boxNumber: 1),
        ScoreImage(boxImageName: "boxleft", boxNumber: 2),
        ScoreImage(boxImageName: "boxleft", boxNumber: 3),
        ScoreImage(boxImageName: "boxleft", boxNumber: 4),
        ScoreImage(boxImageName: "boxleft", boxNumber: 5),
        ScoreImage(boxImageName: "boxleft", boxNumber: 6),
        ScoreImage(boxImageName: "boxleft", boxNumber: 7),
        ScoreImage(boxImageName: "boxleft", boxNumber: 8),
        ScoreImage(boxImageName: "boxleft", boxNumber: 9),
        ScoreImage(boxImageName: "boxleft", boxNumber: 10),
        ScoreImage(boxImageName: "boxleft", boxNumber: 11),
        ScoreImage(boxImageName: "boxleft", boxNumber: 12),
        ScoreImage(boxImageName: "boxleft", boxNumber: 13),
        ScoreImage(boxImageName: "boxleft", boxNumber: 14),
        ScoreImage(boxImageName: "boxleft", boxNumber: 15),
        ScoreImage(boxImageName: "boxleft", boxNumber: 16),
        ScoreImage(boxImageName: "boxleft", boxNumber: 17),
        ScoreImage(boxImageName: "boxleft", boxNumber: 18),
        ScoreImage(boxImageName: "boxleft", boxNumber: 19),
        ScoreImage(boxImageName: "boxleft", boxNumber: 20),
        ScoreImage(boxImageName: "boxrightend", boxNumber: 21)
    ]
    
    @State var scoreImagesRow5 = [
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 1),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 2),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 3),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 4),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 5),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 6),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 7),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 8),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 9),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 10),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 11),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 12),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 13),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 14),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 15),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 16),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 17),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 18),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 19),
        ScoreImage(boxImageName: "boxbottomrowleft", boxNumber: 20),
        ScoreImage(boxImageName: "box", boxNumber: 21)
    ]
    
    */
    
//    @State var timeouts2ImagesRow1 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "")
//    ]
//
//    @State var timeouts2ImagesRow2 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "")
//    ]
//
//    @State var timeouts2ImagesRow3 = [
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "box", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "")
//    ]
//
//    @State var timeouts2ImagesRow3A = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "")
//    ]
//
//    @State var timeouts2ImagesRow4 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "")
//    ]
//
//    @State var timeouts2ImagesRow5 = [
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "box", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxblank", boxNumber: "")
//    ]
//
//    @State var timeouts3ImagesRow1 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "3")
//    ]
//
//    @State var timeouts3ImagesRow2 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "3")
//    ]
//
//    @State var timeouts3ImagesRow3 = [
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "box", boxNumber: "3")
//    ]
//
//    @State var timeouts3ImagesRow3A = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "3")
//    ]
//
//    @State var timeouts3ImagesRow4 = [
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxleft", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "boxrightend", boxNumber: "3")
//    ]
//
//    @State var timeouts3ImagesRow5 = [
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "1"),
//        TimeoutImageX(boxImageName: "boxbottomrowleft", boxNumber: "2"),
//        TimeoutImageX(boxImageName: "box", boxNumber: "3")
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
                //  Index values in realm are 0 - 20
                ForEach(0..<21) { index in
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
                
                
                //                Keeping this code for reference
                //                ForEach(scoreImagesRow1) { scoreimage in
                //                    ZStack {
                //                        Image(scoreimage.boxImageName)
                //                            .resizable()
                //                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                //                        if scoreimage.isShowSideOut {
                //                            Image(scoreimage.sideOutImageName)
                //                                .resizable()
                //                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                //                        }
                //                        Text("\(scoreimage.boxNumber)")
                //                            .font(.callout)
                //                            .foregroundColor(.secondary).opacity(0.8)
                //                    }
                //                }
                
                
                Image("boxblank")
                    .resizable()
                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                
                // Game 1 row of tdimeouts
                ForEach(0..<3) { index in
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
                
//                Keeping this code for reference
//                ForEach(timeouts2ImagesRow1) { timeoutimage in
//                    ZStack {
//                        Image(timeoutimage.boxImageName)
//                            .resizable()
//                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
//                        if timeoutimage.isShowScore {
//                            Image(timeoutimage.score)
//                                .resizable()
//                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
//                        }
//                        Text(timeoutimage.boxNumber)
//                            .font(.callout)
//                            .foregroundColor(.secondary).opacity(0.8)
//                    }
//                }
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
                // index values in realm are 21 - 41
                ForEach(21..<42) { index in
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
                
                ForEach(3..<6) { index in
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
                    // index values in realm are 42 - 62
                    ForEach(42..<63) { index in
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
                    
                    ForEach(6..<9) { index in
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
                    // index values in realm are 210 - 230
                    ForEach(210..<231) { index in
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
                    
                    ForEach(31..<34) { index in
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
                    // index values in realm are 63 - 83
                    ForEach(63..<84) { index in
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
                    
                    ForEach(9..<12) { index in
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
                    // index values in realm are 84 - 104
                    ForEach(84..<105) { index in
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
                    
                    ForEach(12..<15) { index in
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



//struct ScoringRowsTeam1View_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoringRowsTeam1View()
//    }
//}

