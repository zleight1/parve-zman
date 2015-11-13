//
//  ParveZmanHomeTableViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 11/10/15.
//  Copyright © 2015 Zachary Leighton. All rights reserved.
//

import UIKit

class ParveZmanHomeTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    private struct NavItems {
        static let RowsCount = 3
        static let DemoAnimationDuration = 1.0
        static let buttons: [(String, UIColor)] = [
            (   title:"Meat",
                color:UIColor.redColor()
            ),
            (   title:"Dairy",
                color:UIColor.blueColor()
            ),
            (   title:"Settings",
                color:UIColor.grayColor()
            )
        ]
    }
    
    let pzCellIdentifier: String = "PZHomeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NavItems.RowsCount
    }
    
    func getButtonItemAtIndex(index: Int) -> (title:String, color:UIColor) {
        return NavItems.buttons[index]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(pzCellIdentifier, forIndexPath: indexPath)
        
        let colorIndex = indexPath.row % NavItems.buttons.count
        
        let item = self.getButtonItemAtIndex(colorIndex)
        cell.backgroundColor = item.color
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    
    func navCellAtIndexPath(indexPath:NSIndexPath) -> PZHomeTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(pzCellIdentifier) as! PZHomeTableViewCell
        setTitleForCell(cell, indexPath: indexPath)
        setColorForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setTitleForCell(cell:PZHomeTableViewCell, indexPath:NSIndexPath) {
        let item = self.getButtonItemAtIndex(indexPath.row)
        cell.titleLabel.text = item.title
    }
    
    func setColorForCell(cell:PZHomeTableViewCell, indexPath:NSIndexPath) {
        let item = self.getButtonItemAtIndex(indexPath.row)
        cell.backgroundColor = item.color
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        self.performSegueWithIdentifier("ShowSettings", sender: cell)
    }
    
    // MARK: - Navigation
    
    private let animationController = DAExpandAnimation()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destinationViewController
        
        if let selectedCell = sender as? UITableViewCell {
            toViewController.transitioningDelegate = self
            toViewController.modalPresentationStyle = .Custom
            toViewController.view.backgroundColor = selectedCell.backgroundColor
            
            animationController.collapsedViewFrame = {
                return selectedCell.frame
            }
            animationController.animationDuration = NavItems.DemoAnimationDuration
            
            if let indexPath = tableView.indexPathForCell(selectedCell) {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animationController
    }
    
    func configureTableView() {
        tableView.rowHeight = view.frame.height / CGFloat(NavItems.buttons.count)
        tableView.estimatedRowHeight = 160.0
    }
    
}
