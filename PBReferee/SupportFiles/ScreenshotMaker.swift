//
//  ScreenshotMaker.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/8/22.
//

import UIKit

class ScreenshotMaker: UIView {
    /// Takes the screenshot of the superview of this superview
    /// - Returns: The UIImage with the screenshot of the view
    func screenshot() -> UIImage? {
        guard let containerView = self.superview?.superview,
              let containerSuperview = containerView.superview else { return nil }
        let renderer = UIGraphicsImageRenderer(bounds: containerView.frame)
        return renderer.image { (context) in
            containerSuperview.layer.render(in: context.cgContext)
        }
    }
}

