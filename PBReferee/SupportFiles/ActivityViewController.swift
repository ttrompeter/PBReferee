//
//  ActivityViewController.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/12/22.
//

import Foundation
import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIActivityViewController
    

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil    // How to make an array of these?? ["print"]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}


