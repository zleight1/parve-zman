//
//  ParveZmanHomeTableViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 11/10/15.
//  Copyright © 2015 Zachary Leighton. All rights reserved.
//

import UIKit
import SCLAlertView

class PZHomeTableViewController: UITableViewController {
    
    private struct NavItems {
        static let RowsCount = 3
        static let DemoAnimationDuration = 1.0
        static let buttons: [(String, UIColor, Int)] = [
            (   title:"Meat",
                color:UIColor.init(hexString: "#F2362C"),
                tag: 0
            ),
            (   title:"Dairy",
                color:UIColor.init(hexString: "#1A7CF9"),
                tag: 1
            ),
            (   title:"Settings",
                color:UIColor.init(hexString: "#A9A9A9"),
                tag:2
            )
        ]
    }
    
    let pzCellIdentifier: String = "PZHomeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        
        //Load from core data if possible
        PZSettingsManager.sharedInstance.loadPZSettings()
        
        self.title = "ParveZman"
        self.navigationController!.navigationBar.backgroundColor = UIColor.greenColor()
        self.navigationController!.navigationBar.barTintColor = UIColor.greenColor()
        
        
        self.navigationController!.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(CGFloat(24.0))
        ]
        
        //Set this back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(CGFloat(24.0))], forState: UIControlState.Normal)
        navigationItem.backBarButtonItem = backButton
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "ParveZman"
        self.navigationController!.navigationBar.backgroundColor = UIColor.greenColor()
        self.navigationController!.navigationBar.barTintColor = UIColor.greenColor()

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
    
    func getButtonItemAtIndex(index: Int) -> (title:String, color:UIColor, tag:Int) {
        return NavItems.buttons[index]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(pzCellIdentifier, forIndexPath: indexPath)
        
        let colorIndex = indexPath.row % NavItems.buttons.count
        
        let item = self.getButtonItemAtIndex(colorIndex)
        cell.backgroundColor = item.color
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(CGFloat(36.0))
        cell.tag = item.tag
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
        
        switch cell.tag {
        case 0, 1:
            self.showTimer(cell.tag)
        case 2:
            self.showSettings()
        default:
            return
        }
        return
    }
    
    func showTimer(tag: Int){
        //check if we're in timer mode currently?

        
        
        //get the time
        var time: Double
        var type: String
        if tag == 0 {
            time = PZMinhag.GetTimeFromMinhag(PZSettingsManager.sharedInstance.currentMeatMinhag)
            type = "meat"
        } else {
            time = PZMinhag.GetTimeFromMinhag(PZSettingsManager.sharedInstance.currentDairyMinhag)
            type = "dairy"
        }
        
        //check if time is less than one
        if time < 1 {
            let alert = SCLAlertView()
            alert.showInfo("No Wait Time", subTitle:"You don't have a minhag to wait, just eat something parve before in between.")
            return
        }
        
        //get the timer view
        let pzTimerViewController = storyboard!.instantiateViewControllerWithIdentifier("PZTimerViewController") as! PZTimerViewController
        
        //pass the view controller all the information it needs here
        pzTimerViewController.endTime = NSDate.timeIntervalSinceReferenceDate() + time
        
        self.navigationController?.pushViewController(pzTimerViewController, animated: true)
        
        return

    }
    
    func showSettings() {
        //get the timer view
        let pzSettingsViewController = storyboard!.instantiateViewControllerWithIdentifier("PZSettingsViewController") as! PZSettingsViewController
        
        self.navigationController?.pushViewController(pzSettingsViewController, animated: true)
        
        return
    }
    
    func configureTableView() {
        let tableHeight = view.frame.height - self.navigationController!.navigationBar.frame.height
        tableView.rowHeight = tableHeight / CGFloat(NavItems.buttons.count)
        tableView.estimatedRowHeight = 160.0
    }
    
}
