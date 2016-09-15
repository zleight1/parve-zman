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
    
    fileprivate struct NavItems {
        static let RowsCount = 3
        static let DemoAnimationDuration = 1.0
        static let buttons: [(String, UIColor, Int)] = [
            (   title:"Meat",
                color:PZUtils.sharedInstance.flatRedColor,
                tag: 0
            ),
            (   title:"Dairy",
                color:PZUtils.sharedInstance.flatBlueColor,
                tag: 1
            ),
            (   title:"Settings",
                color:PZUtils.sharedInstance.flatGrayColor,
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
        self.navigationController!.navigationBar.backgroundColor = UIColor.green
        self.navigationController!.navigationBar.tintColor = UIColor.white
        
        
        self.navigationController!.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        ]
        
        //Set this back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(24.0))], for: UIControlState())
        navigationItem.backBarButtonItem = backButton
        
        //Once all the view information has been set up try and load an existing timer if possible
        
        //check if a timer was active before
        let timerManager = PZTimerManager()
        if timerManager.isTimerActive() {
            
            let data = timerManager.loadPZTimerData()
            
            let endDate: Date = data!.value(forKey: "endTime") as! Date;
            let endTime = endDate.timeIntervalSinceReferenceDate
            let timerType = data?.value(forKey: "timerType") as! String
            
            return showTimer(endTime, timerType: timerType, setNotification: false)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "ParveZman"
        self.navigationController!.navigationBar.backgroundColor = PZUtils.sharedInstance.flatGreenColor
        self.navigationController!.navigationBar.barTintColor = PZUtils.sharedInstance.flatGreenColor

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NavItems.RowsCount
    }
    
    func getButtonItemAtIndex(_ index: Int) -> (title:String, color:UIColor, tag:Int) {
        return NavItems.buttons[index]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pzCellIdentifier, for: indexPath)
        
        let colorIndex = (indexPath as NSIndexPath).row % NavItems.buttons.count
        
        let item = self.getButtonItemAtIndex(colorIndex)
        cell.backgroundColor = item.color
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.systemFont(ofSize: CGFloat(36.0))
        cell.tag = item.tag
        return cell
    }
    
    
    func navCellAtIndexPath(_ indexPath:IndexPath) -> PZHomeTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pzCellIdentifier) as! PZHomeTableViewCell
        setTitleForCell(cell, indexPath: indexPath)
        setColorForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setTitleForCell(_ cell:PZHomeTableViewCell, indexPath:IndexPath) {
        let item = self.getButtonItemAtIndex((indexPath as NSIndexPath).row)
        cell.titleLabel.text = item.title
    }
    
    func setColorForCell(_ cell:PZHomeTableViewCell, indexPath:IndexPath) {
        let item = self.getButtonItemAtIndex((indexPath as NSIndexPath).row)
        cell.backgroundColor = item.color
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        
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
    
    func showTimer(_ tag: Int){
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
        
        return showTimer(Date.timeIntervalSinceReferenceDate + time, timerType: type, setNotification: true)
    }
    
    func showTimer(_ endTime: TimeInterval, timerType: String, setNotification: Bool){
        //get the timer view
        let pzTimerViewController = storyboard!.instantiateViewController(withIdentifier: "PZTimerViewController") as! PZTimerViewController
        
        //pass the view controller all the information it needs here
        pzTimerViewController.endTime = endTime
        pzTimerViewController.type = timerType
        pzTimerViewController.setLocalNotification = setNotification
        
        self.navigationController?.pushViewController(pzTimerViewController, animated: true)
        
        return

    }
    
    func showSettings() {
        //get the timer view
        let pzSettingsViewController = storyboard!.instantiateViewController(withIdentifier: "PZSettingsViewController") as! PZSettingsViewController
        
        self.navigationController?.pushViewController(pzSettingsViewController, animated: true)
        
        return
    }
    
    func configureTableView() {
        let tableHeight = view.frame.height - self.navigationController!.navigationBar.frame.height
        tableView.rowHeight = tableHeight / CGFloat(NavItems.buttons.count)
        tableView.estimatedRowHeight = 160.0
    }
    
}
