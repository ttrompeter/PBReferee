//
//  NavigationButtonsView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//
import RealmSwift
//import ScreenshotSwiftUI
import SwiftUI

struct FunctionalityButtonsView: View {
    
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var match: Match
    @State var screenshotMaker: ScreenshotMaker?
    
    var body: some View {
        
        VStack  {
            Spacer()
            TopButtonsView(match: match)
            VStack (spacing: 1) {
                if !match.isServingLeftSide {
                    Image(systemName: "arrow.right.square")
                        .font(.system(size: 90))
                } else {
                    Image(systemName: "arrow.left.square")  // Left arrow
                        .font(.system(size: 90))
                }
            }
            BottomButtonsView(match: match)
            Spacer()
        }
//        .screenshotMaker { screenshotMaker in
//            screenshotMaker.screenshot()?.saveFunctionalityButtonsToDocuments()
//        }
    }
}

struct FunctionalityButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionalityButtonsView(match: Match())
    }
}

