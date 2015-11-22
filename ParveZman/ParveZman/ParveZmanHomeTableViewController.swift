//
//  ParveZmanHomeTableViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 11/10/15.
//  Copyright © 2015 Zachary Leighton. All rights reserved.
//

import UIKit

class ParveZmanHomeTableViewController: UITableViewController {
    
    private struct NavItems {
        static let RowsCount = 3
        static let DemoAnimationDuration = 1.0
        static let buttons: [(String, UIColor)] = [
            (   title:"Meat",
                color:UIColor.init(hexString: "#F2362C")
            ),
            (   title:"Dairy",
                color:UIColor.init(hexString: "#1A7CF9")
            ),
            (   title:"Settings",
                color:UIColor.init(hexString: "#A9A9A9")
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
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(CGFloat(36.0))
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destinationViewController
        
        if let selectedCell = sender as? UITableViewCell {
            toViewController.modalPresentationStyle = .Custom
            //toViewController.view.backgroundColor = selectedCell.backgroundColor
            
            
            if let indexPath = tableView.indexPathForCell(selectedCell) {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    func configureTableView() {
        let headerHeight = CGFloat(60.0)
        
        let tableHeight = view.frame.height - headerHeight
        tableView.rowHeight = tableHeight / CGFloat(NavItems.buttons.count)
        tableView.estimatedRowHeight = 160.0
        
        let tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight))
        
        let tableViewHeaderText = UILabel(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: headerHeight))
        tableViewHeaderText.textColor = UIColor.whiteColor()
        tableViewHeaderText.backgroundColor = UIColor.clearColor()
        tableViewHeaderText.font = UIFont.boldSystemFontOfSize(CGFloat(24.0))
        tableViewHeaderText.text = "ParveZman"
        tableViewHeaderText.textAlignment = .Center
        
        tableViewHeader.addSubview(tableViewHeaderText)
        
        
        tableViewHeader.backgroundColor = UIColor.greenColor()
        tableView.tableHeaderView  = tableViewHeader
        
    }
    
}
