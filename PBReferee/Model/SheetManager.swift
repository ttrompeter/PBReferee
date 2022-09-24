//
//  SheetManager.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/10/22.
//
// From tunsdev tutorial
// Build a Csutom Popup in SwiftUI: https://www.youtube.com/watch?v=OaIn7HBlCSk
//  tundsdev YouTube channel: https://www.youtube.com/c/tundsdev?su...
//

import Foundation

final class SheetManager: ObservableObject {
    
    typealias Config = SheetAction.Info
    
    enum SheetAction {
        
        struct Info {
            let systemName: String
            let title: String
            let content: String
        }
        
        case notAvailable
        case present(info: Info)
        case dismiss
    }
    
    @Published private(set) var action: SheetAction = .notAvailable
    
    func present(with config: Config) {
        // guard to see if already presented so don't present twice
        guard !action.isPresented else { return }
        self.action = .present(info: config)
    }
    
    func dismiss() {
        self.action = .dismiss
    }
    
}

extension SheetManager.SheetAction {
    // Tells if presented instead of using == on each case. Computed value.
    var isPresented: Bool {
        guard case.present(_) = self else { return false }
        return true
        
    }
}

