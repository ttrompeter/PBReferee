//
//  StatisticsView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import ScreenshotSwiftUI
import SwiftUI

struct StatisticsAdminView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var match: Match
    //@State var screenshotMaker: ScreenshotMaker?
    @State private var showMailView = false
    @State private var showPrintView = false
    @State private var imageToUse = UIImage()
    
    // // TODO: - Fix recipients for email instead of hardcoded value
    @State private var mailData = ComposeMailData(subject: "Pickleball Statistics Report",
                                                  recipients: ["ttrompeter@zoho.com"],
                                                  message: "Statistics report sent from Pickleball Referee. Document is attached.",
                                                  attachments:  [])
    
    private var totalMatchTimeoutsTeam1: String {
        let totalTimeouts = match.games[0].timeOutsTakenTeam1 + match.games[1].timeOutsTakenTeam1 + match.games[2].timeOutsTakenTeam1 + match.games[3].timeOutsTakenTeam1 + match.games[4].timeOutsTakenTeam1
        return String(totalTimeouts)
    }
    
    private var totalMatchTimeoutsTeam2: String {
        let totalTimeouts = match.games[0].timeOutsTakenTeam2 + match.games[1].timeOutsTakenTeam2 + match.games[2].timeOutsTakenTeam2 + match.games[3].timeOutsTakenTeam2 + match.games[4].timeOutsTakenTeam2
        return String(totalTimeouts)
    }
    
    private var totalMatchSideoutsTeam1: String {
        let totalSideouts = match.games[0].sideOutsTeam1 + match.games[1].sideOutsTeam1 + match.games[2].sideOutsTeam1 + match.games[3].sideOutsTeam1 + match.games[4].sideOutsTeam1
        return String(totalSideouts)
    }
    
    private var totalMatchSideoutsTeam2: String {
        let totalSideouts = match.games[0].sideOutsTeam2 + match.games[1].sideOutsTeam2 + match.games[2].sideOutsTeam2 + match.games[3].sideOutsTeam2 + match.games[4].sideOutsTeam2
        return String(totalSideouts)
    }
    
    
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Match Statistics ")
                    .bold()
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Constants.DARK_SLATE)
                
                MatchStatisticsView(match: match)
                MatchStatisticsIIView(match: match)
                Text(" ")  // Spacer for screenshot view to be proper layout
            }
            .screenshotMaker { screenshotMaker in
                screenshotMaker.screenshot()?.saveStatisticsToDocuments()
            }
//            .screenshotView { screenshotMaker in self.screenshotMaker = screenshotMaker }
//            .onAppear {
//                print("In onAppear of first sub VStack in StatisticsAdminView ")
//                if let screenshotMaker = screenshotMaker {
//                    print("In if let screenshotMaker of onAppear of first sub VStack in StstisticsAdminView")
//                    screenshotMaker.screenshot()?.saveStatisticsToDocuments()
//                    print("Took screenshot automatically of statistics in StatisticsAdminView")
//                }
//            }
            
            VStack {
                HStack {
                    Group {
                        Spacer()
                        Button(action: {
                            showPrintView = true
                            
                        }) {
                            Image("printer")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipped()
                        }
                        .sheet(isPresented: $showPrintView) {
                            ActivityViewController(activityItems: [imageToUse])
                        }
                        Text("Print")
                        Spacer()
                        
                        Button(action: {
                            showMailView = true
                        }) {
                            Image("envelope")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipped()
                        }
                        .disabled(!MailView.canSendMail)
                        .sheet(isPresented: $showMailView) {
                            MailView(data: $mailData) { result in
                                print(result)
                            }
                        }
                        Text("Email")
                        Spacer()
                    }
                    
                    Button(action: {
//                        if let screenshotMaker = screenshotMaker {
//                            screenshotMaker.screenshot()?.saveStatisticsToDocuments()
//                            print("Took screenshot manually of statistics in StatisticsAdminView")
//                        }
                    }) {
                        Image("camera")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .clipped()
                    }
                    Text("Screenshot")
                    Spacer()
                }
            }
            .padding(.horizontal, 40)
           
            HStack (spacing: 40) {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 20)
            
        }  // Top VStack
//        .onAppear {
//            print("In onAppear of Top VStack in StatisticsAdminView ")
//            if let screenshotMaker = screenshotMaker {
//                print("In if let screenshotMaker of onAppear of Top VStack in StstisticsAdminView")
//                screenshotMaker.screenshot()?.saveStatisticsToDocuments()
//                print("Took screenshot automatically of statistics in StatisticsAdminView onAppear top VStack")
//            }
//        }
    }
    
    func formatElapsedTimeMinutes(value: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        let number = NSNumber(value: value)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }
}

struct StatisticsAdminView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsAdminView(match: Match())
    }
}

