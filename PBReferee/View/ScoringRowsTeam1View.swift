//
//  ScoringRowsTeam1View.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 9/21/22.
//

import SwiftUI

struct ScoringRowsTeam1View: View {
    
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

    
    @State var scoreImagesRow1 = [
        ScoreImage(boxImageName: "boxleft", boxNumber: "1"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "2"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "3"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "4"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "5"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "6"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "7"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "8"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "9"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "10"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "11"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "12"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "13"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "14"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "15"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "16"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "17"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "18"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "19"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "20"),
        ScoreImage(boxImageName: "boxrightend", boxNumber: "21")
    ]
    
    @State var scoreImagesRow2 = [
        
        ScoreImage(boxImageName: "boxleft", boxNumber: "1"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "2"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "3"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "4"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "5"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "6"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "7"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "8"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "9"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "10"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "11"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "12"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "13"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "14"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "15"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "16"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "17"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "18"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "19"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "20"),
        ScoreImage(boxImageName: "boxrightend", boxNumber: "21")
    ]
    
    @State var scoreImagesRow3 = [
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "1"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "2"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "3") ,
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "4"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "5"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "6"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "7"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "8"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "9"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "10"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "11"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "12"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "13"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "14"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "15"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "16"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "17"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "18"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "19"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "20"),
        ScoreImage(boxImageName: "box", boxNumber: "21")
    ]
    
    @State var scoreImagesRow3A = [
        ScoreImage(boxImageName: "boxleft", boxNumber: "1"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "2"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "3") ,
        ScoreImage(boxImageName: "boxleft", boxNumber: "4"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "5"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "6"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "7"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "8"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "9"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "10"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "11"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "12"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "13"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "14"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "15"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "16"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "17"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "18"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "19"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "20"),
        ScoreImage(boxImageName: "boxrightend", boxNumber: "21")
    ]
    
    @State var scoreImagesRow4 = [
        ScoreImage(boxImageName: "boxleft", boxNumber: "1"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "2"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "3"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "4"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "5"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "6"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "7"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "8"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "9"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "10"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "11"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "12"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "13"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "14"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "15"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "16"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "17"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "18"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "19"),
        ScoreImage(boxImageName: "boxleft", boxNumber: "20"),
        ScoreImage(boxImageName: "boxrightend", boxNumber: "21", isShowSideOut: false, sideOutImageName: "sideoutright")
    ]
    
    @State var scoreImagesRow5 = [
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "1"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "2"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "3"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "4"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "5"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "6"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "7"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "8"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "9"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "10"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "11"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "12"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "13"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "14"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "15"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "16"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "17"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "18"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "19"),
        ScoreImage(boxImageName: "boxbottomleft", boxNumber: "20"),
        ScoreImage(boxImageName: "box", boxNumber: "21", isShowSideOut: false, sideOutImageName: "sideoutright")
    ]
    
    @State var timeouts2ImagesRow1 = [
        TimeoutImage(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxrightend", boxNumber: "2", isShowScore: false, score: "2/5"),
        TimeoutImage(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
    ]
    
    @State var timeouts2ImagesRow2 = [
        TimeoutImage(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxrightend", boxNumber: "2", isShowScore: false, score: "2/5"),
        TimeoutImage(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
    ]
    
    @State var timeouts2ImagesRow3 = [
        TimeoutImage(boxImageName: "boxbottomleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "box", boxNumber: "2", isShowScore: false, score: "2/5"),
        TimeoutImage(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
    ]
    
    @State var timeouts2ImagesRow3A = [
        TimeoutImage(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxrightend", boxNumber: "2", isShowScore: false, score: "2/5"),
        TimeoutImage(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
    ]
    
    @State var timeouts2ImagesRow4 = [
        TimeoutImage(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxrightend", boxNumber: "2", isShowScore: false, score: "2/5"),
        TimeoutImage(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
    ]
    
    @State var timeouts2ImagesRow5 = [
        TimeoutImage(boxImageName: "boxbottomleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "box", boxNumber: "2", isShowScore: false, score: "2/5"),
        TimeoutImage(boxImageName: "boxblank", boxNumber: "", isShowScore: false, score: "")
    ]
    
    @State var timeouts3ImagesRow1 = [
        TimeoutImage(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxleft", boxNumber: "2", isShowScore: false, score: "4/3"),
        TimeoutImage(boxImageName: "boxrightend", boxNumber: "3", isShowScore: false, score: "2/5")
    ]
    
    @State var timeouts3ImagesRow2 = [
        TimeoutImage(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxleft", boxNumber: "2", isShowScore: false, score: "4/3"),
        TimeoutImage(boxImageName: "boxrightend", boxNumber: "3", isShowScore: false, score: "2/5")
    ]
    
    @State var timeouts3ImagesRow3 = [
        TimeoutImage(boxImageName: "boxbottomleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxbottomleft", boxNumber: "2", isShowScore: false, score: "4/3"),
        TimeoutImage(boxImageName: "box", boxNumber: "3", isShowScore: false, score: "2/5")
    ]
    
    @State var timeouts3ImagesRow3A = [
        TimeoutImage(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxleft", boxNumber: "2", isShowScore: false, score: "4/3"),
        TimeoutImage(boxImageName: "boxrightend", boxNumber: "3", isShowScore: false, score: "2/5")
    ]
    
    @State var timeouts3ImagesRow4 = [
        TimeoutImage(boxImageName: "boxleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxleft", boxNumber: "2", isShowScore: false, score: "4/3"),
        TimeoutImage(boxImageName: "boxrightend", boxNumber: "3", isShowScore: false, score: "2/5")
    ]
    
    @State var timeouts3ImagesRow5 = [
        TimeoutImage(boxImageName: "boxbottomleft", boxNumber: "1", isShowScore: false, score: "1/6"),
        TimeoutImage(boxImageName: "boxbottomleft", boxNumber: "2", isShowScore: false, score: "4/3"),
        TimeoutImage(boxImageName: "box", boxNumber: "3", isShowScore: false, score: "2/5")
    ]
    
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
                
                ForEach(scoreImagesRow1) { scoreimage in
                    ZStack {
                        Image(scoreimage.boxImageName)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        if scoreimage.isShowSideOut {
                            Image(scoreimage.sideOutImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        }
                        Text(scoreimage.boxNumber)
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                }
                
                Image("boxblank")
                    .resizable()
                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                
                ForEach(timeouts2ImagesRow1) { timeoutimage in
                    ZStack {
                        Image(timeoutimage.boxImageName)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        if timeoutimage.isShowScore {
                            Image(timeoutimage.score)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        }
                        Text(timeoutimage.boxNumber)
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
                
                ForEach(scoreImagesRow2) { scoreimage in
                    ZStack {
                        Image(scoreimage.boxImageName)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        if scoreimage.isShowSideOut {
                            Image(scoreimage.sideOutImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        }
                        Text(scoreimage.boxNumber)
                            .font(.callout)
                            .foregroundColor(.secondary).opacity(0.8)
                    }
                }
                
                Image("boxblank")
                    .resizable()
                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                
                ForEach(timeouts2ImagesRow2) { timeoutimage in
                    ZStack {
                        Image(timeoutimage.boxImageName)
                            .resizable()
                            .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        if timeoutimage.isShowScore {
                            Image(timeoutimage.score)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                        }
                        Text(timeoutimage.boxNumber)
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
                    
                    ForEach(scoreImagesRow3) { scoreimage in
                        ZStack {
                            Image(scoreimage.boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if scoreimage.isShowSideOut {
                                Image(scoreimage.sideOutImageName)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(scoreimage.boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                    
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    ForEach(timeouts2ImagesRow3) { timeoutimage in
                        ZStack {
                            Image(timeoutimage.boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if timeoutimage.isShowScore {
                                Image(timeoutimage.score)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(timeoutimage.boxNumber)
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
                    
                    ForEach(scoreImagesRow3A) { scoreimage in
                        ZStack {
                            Image(scoreimage.boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if scoreimage.isShowSideOut {
                                Image(scoreimage.sideOutImageName)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(scoreimage.boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                    
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    ForEach(timeouts2ImagesRow3A) { timeoutimage in
                        ZStack {
                            Image(timeoutimage.boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if timeoutimage.isShowScore {
                                Image(timeoutimage.score)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(timeoutimage.boxNumber)
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
                    
                    ForEach(scoreImagesRow4) { scoreimage in
                        ZStack {
                            Image(scoreimage.boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if scoreimage.isShowSideOut {
                                Image(scoreimage.sideOutImageName)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(scoreimage.boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                    
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    ForEach(timeouts2ImagesRow4) { timeoutimage in
                        ZStack {
                            Image(timeoutimage.boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if timeoutimage.isShowScore {
                                Image(timeoutimage.score)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(timeoutimage.boxNumber)
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
                    
                    ForEach(scoreImagesRow5) { scoreimage in
                        ZStack {
                            Image(scoreimage.boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if scoreimage.isShowSideOut {
                                Image(scoreimage.sideOutImageName)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(scoreimage.boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                    
                    Image("boxblank")
                        .resizable()
                        .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                    
                    ForEach(timeouts2ImagesRow5) { timeoutimage in
                        ZStack {
                            Image(timeoutimage.boxImageName)
                                .resizable()
                                .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            if timeoutimage.isShowScore {
                                Image(timeoutimage.score)
                                    .resizable()
                                    .frame(width: Constants.BOX_DIMENSION, height: Constants.BOX_DIMENSION)
                            }
                            Text(timeoutimage.boxNumber)
                                .font(.callout)
                                .foregroundColor(.secondary).opacity(0.8)
                        }
                    }
                }
            }
        }
    }
}



struct ScoringRowsTeam1View_Previews: PreviewProvider {
    static var previews: some View {
        ScoringRowsTeam1View()
    }
}

