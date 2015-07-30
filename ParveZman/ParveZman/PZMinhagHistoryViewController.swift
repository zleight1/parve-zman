//
//  PZMinhagHistoryViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/7/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import UIKit

class PZMinhagHistoryViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController?
    var minhagTitles: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Set title
        self.title = "Minhag History"
        
        //Set array of page titles
        minhagTitles += PZMinhag.GetAllMeatNames() + PZMinhag.GetAllDairyNames()
        
        //Init the page view controller
        self.pageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PZMinhagHistoryViewController") as! PZMinhagHistoryPageViewController
        
        self.pageViewController?.dataSource = self
        
        var startingViewController = self.viewControllerAtIndex(0)
        
        var viewControllers: [AnyObject!] = [startingViewController]
        
        self.pageViewController!.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.pageViewController!.view.frame = CGRectMake(0,0, self.view.frame.size.width * 1.0, self.view.frame.size.height * 1.0)
        
        self.addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        self.pageViewController?.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! PZMinhagHistoryContentViewController).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! PZMinhagHistoryContentViewController).pageIndex
        if index == NSNotFound {
            return nil
        }
        index++
        if index == self.minhagTitles.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> PZMinhagHistoryContentViewController? {
        //Check bounds
        if self.minhagTitles.count == 0 || index >= self.minhagTitles.count {
            return nil;
        }
        
        var minhagContentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PZMinhagHistoryContentViewController") as! PZMinhagHistoryContentViewController
        
        minhagContentViewController.minhagTitle = self.minhagTitles[index]
        minhagContentViewController.pageIndex = index
        
        return minhagContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.minhagTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
