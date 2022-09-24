//
//  ExtensionView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/8/22.
//
import Foundation
import SwiftUI

extension View {
    /// from HWS take a screenshot by wrapping the View inside a UIHostingController
    /// then create a UIImage from a UIGraphicsImageRenderer
//    func snapshot(environment: Match) -> UIImage {
//        let controller = UIHostingController(rootView: self.environmentObject(environment))
//        let view = controller.view
//
//        let targetSize = controller.view.intrinsicContentSize
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.backgroundColor = .clear
//
//        let renderer = UIGraphicsImageRenderer(size: targetSize)
//
//        return renderer.image { _ in
//            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
//        }
//    }
    
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension View {
    func screenshotView(_ closure: @escaping ScreenshotMakerClosure) -> some View {
        let screenshotView = ScreenshotMakerView(closure)
        return overlay(screenshotView.allowsHitTesting(false))
    }
}


