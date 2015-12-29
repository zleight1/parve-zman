//
//  UIViewController+BackButtonHandler.swift
//  ParveZman
//
//  Created by Zachary Leighton on 12/22/15.
//  Copyright © 2015 Zachary Leighton. All rights reserved.
//

import Foundation
import UIKit


protocol BackButtonHandlerProtocol {
    // Override this method in UIViewController derived class to handle 'Back' button click
    func navigationShouldPopOnBackButton() -> Bool
}

extension UIViewController: BackButtonHandlerProtocol {
    func navigationShouldPopOnBackButton() -> Bool {
        return true
    }
}

extension UINavigationController {
    func navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
        if self.viewControllers.count < navigationBar.items!.count {
            return true
        }
        var shouldPop: Bool = true
        let vc: UIViewController = self.topViewController!
        if vc.respondsToSelector("navigationShouldPopOnBackButton") {
            shouldPop = vc.navigationShouldPopOnBackButton()
        }
        if shouldPop {
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.popViewControllerAnimated(true)
            })
        }
        else {
            // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
            for subview: UIView in navigationBar.subviews {
                if subview.alpha < 1.0 {
                    UIView.animateWithDuration(0.25, animations: {() -> Void in
                        subview.alpha = 1.0
                    })
                }
            }
        }
        return false
    }
}