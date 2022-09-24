//
//  PreMatchBriefingView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import SwiftUI

struct PreMatchBriefingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack (spacing: 30) {
            
            Text("Pre-Match Briefing")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Constants.DARK_SLATE)
            
            ZStack {
                Rectangle()
                    .frame(width: CGFloat(660), height: CGFloat(500))
                    .foregroundColor(Constants.CLOUDS)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                VStack (alignment: .leading, spacing: 8) {
                    Group {
                        Text("Pre-Match Briefing")
                            .font(.headline)
                        Text("\u{2022}") + Text(" Introduction")
                        Text("\u{2022}") + Text(" Confirm Play IDs")
                        Text("\u{2022}") + Text(" Starting Servers / Circle Scoresheet / Wristbands")
                        Text("\u{2022}") + Text(" Inspect paddles  /  Ask - On USAPA Approved List")
                        Text("\u{2022}") + Text(" State Match Format [2 of 3 to 11, win by 2]")
                    }
                    Group {
                        Text("\u{2022}") + Text(" Choose Side/Serve/Receive/Defer   /   Mark scoresheet")
                        Text("\u{2022}") + Text(" Court Hinders  /  Rule Modifications")
                        Text("\u{2022}") + Text(" Referee Line Calling Responsibilities / Foot Faults  /  NVZ /  Serve")
                        Text("\u{2022}") + Text(" Please Make OUT Calls Loudly, Clearly & Promptly")
                        Text("\u{2022}") + Text(" You may appeal opponent’s line call. ")
                        Text("       If you did not see the ball land on your side, you may ask me to make the call. ")
                        Text("       If I saw it, I will rule. ")
                        Text("\u{2022}") + Text(" Questions?")
                        Text(" ")
                        Text("Allow players to warm up for remaining time")
                    }
                    
                }
            }
            Spacer()
            VStack {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 20)
            
        }
    }
  
}

struct PreMatchBriefingView_Previews: PreviewProvider {
    static var previews: some View {
        PreMatchBriefingView()
    }
}

