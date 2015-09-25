//
//  PZAlert.swift
//  ParveZman
//
//  Created by Zachary Leighton on 9/15/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import Foundation
import UIKit

func buildAlert(title: NSString, message: NSString, yesText: NSString, noText: NSString, yesAction: (), noAction: () ) -> UIAlertController {
    let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.Alert)
    
    alert.addAction(UIAlertAction(title: yesText as String, style: .Default, handler: { (action: UIAlertAction) in
        yesAction
    }))
    
    alert.addAction(UIAlertAction(title: noText as String, style: .Default, handler: { (action: UIAlertAction) in
        noAction
    }))
    
    return alert
}