//
//  SpinnerView.swift
//  WisdomLeafTask
//
//  Created by Venkatesh on 18/08/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit
class SpinnerView{
    static let shared:SpinnerView = SpinnerView() // SINGLETON Design Pattern

    var blurView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    public func showOverlay(view: UIView) {
        DispatchQueue.main.async {
            if view.subviews.contains(self.blurView) {

            } else {
                self.removeOverlayBeforeApply()
                self.blurView = UIView(frame: UIScreen.main.bounds)
                self.blurView.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
                self.activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
                self.activityIndicator.center = self.blurView.center
                self.blurView.addSubview(self.activityIndicator)
                self.activityIndicator.startAnimating()
                view.addSubview(self.blurView)
            }
        }
    }
    // This method removes a blur view and activity indicator
    public func hideOverlayView() {
        DispatchQueue.main.async {
            if self.activityIndicator.isAnimating == true {
                self.activityIndicator.stopAnimating()
                self.blurView.removeFromSuperview()
            }
        }
    }
    
    fileprivate func removeOverlayBeforeApply() {
        if self.activityIndicator.isAnimating == true {
            self.activityIndicator.stopAnimating()
            self.blurView.removeFromSuperview()
        }
    }
}
