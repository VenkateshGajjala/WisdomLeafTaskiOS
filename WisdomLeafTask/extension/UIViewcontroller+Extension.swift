//
//  UIViewcontroller+Extension.swift
//  WisdomLeafTask
//
//  Created by Venkatesh on 24/08/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import Foundation
import UIKit
var vSpinner : UIView?
extension UIViewController {
    
    // Presnting alert ciew
    func presentAlertWithTitle(title: String, message : String, vc: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alertController, animated: true)
    }
}
