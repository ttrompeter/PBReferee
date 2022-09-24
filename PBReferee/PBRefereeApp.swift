//
//  PBRefereeApp.swift
//  PBReferee
//
//  Created by Tom Trompeter on 9/23/22.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct PBRefereeApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var realmManager = RealmManager()
    @StateObject var sheetManager = SheetManager()
    
    var scoresheetManager = ScoresheetManager()
    
    var body: some Scene {
        WindowGroup {
            //DataLoadView()
            WelcomeView()
                .environmentObject(sheetManager)
                .environmentObject(scoresheetManager)
                .environmentObject(realmManager)
                .onAppear {
                    // Stop layout conflict messages
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    
                    /*
                     The app provides for printing the scoresheet so it can be turned in just like a paper scorsheet.
                     This is done by first taking a screenshot of the scoresheet page and then allowing the user to
                     print or email the screenshot image. The app also provides for making a screenshot of the statistics
                     page. It too can then by printed or emailed.
                     These images are maintained in the documents directory and there is only one of each. Every time a
                     new screenshot is taken, it replaces the prior one.
                     Also save a sample_scorsheet.png and a sample_statistics.png separaely that they will be available even after
                     screenshots of real scoresheets a statistics pages have been made and saved.
                     These samples will be used until they are replaced by screenshots of the live pages during a match.
                     */
                    
                    // Store the two sample images - sample scoresheet and sample statistics - in the local documentsDirectory data storage
                    // The sample_scorsheet and sample_statistics will be the default images until the user takes screenshots of the real match images
                    // The sample_scorsheet and sample_statistics is also saved separaely so they will also be available to the app
                    storeImage(image: UIImage(named: "sample_scoresheet.png")!, forKey: "scoresheet", withStoragetype: .fileSystem)
                    storeImage(image: UIImage(named: "sample_scoresheet.png")!, forKey: "sample_scoresheet", withStoragetype: .fileSystem)
                    storeImage(image: UIImage(named: "sample_statistics.png")!, forKey: "statistics", withStoragetype: .fileSystem)
                    storeImage(image: UIImage(named: "sample_statistics.png")!, forKey: "sample_statistics", withStoragetype: .fileSystem)
                }
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .active:
                // The scene is in the foreground and interactive.
                print("newScenePhase is .active = in the foreground and interactive")
            case .inactive:
                // The scene is in the foreground but should pause its work.
                print("newScenePhase is .inactive - in the foreground but should pause its work")
            case .background:
                // The scene isn’t currently visible in the UI.
                print("newScenePhase is .background - isn’t currently visible in the UI")
            @unknown default:
                break
            }
        }
        
        
        
    }
}
