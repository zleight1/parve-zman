//
//  PZSettingsViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/7/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import Foundation
import UIKit
import JTImageButton
import SCLAlertView
import CZPicker

class PZSettingsViewController: UITableViewController, CZPickerViewDelegate, CZPickerViewDataSource {
    
    var MeatTimeNames = PZMinhag.GetAllMeatNames();
    var DairyTimeNames = PZMinhag.GetAllDairyNames();
    
    fileprivate struct NavItems {
        static let RowsCount = 2
        static let buttons: [(String, UIColor, Int)] = [
            (   title:"Meat Minhag",
                color:PZUtils.sharedInstance.flatRedColor,
                tag: 0
            ),
            (   title:"Dairy Minhag",
                color:PZUtils.sharedInstance.flatBlueColor,
                tag: 1
            )
        ]
    }
    
    let pzCellIdentifier: String = "PZSettingsCell"
    
    var settingsChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        // Do any additional setup after loading the view.
        self.title = "Settings"
    }
    
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
        
        showSettings(cell.tag)
        
        return
    }

    func showSettings(_ tag: Int) {
        var title = ""
        
        //create colors
        var headerBackgroundColor: UIColor = UIColor.clear
        
        if tag == 0 {
            title = "Meat Minhag"
            headerBackgroundColor = PZUtils.sharedInstance.flatRedColor
        } else if tag == 1 {
            title = "Dairy Minhag"
            headerBackgroundColor = PZUtils.sharedInstance.flatBlueColor
        }
        
        let picker = CZPickerView(headerTitle: title, cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.tag = tag
        picker?.allowMultipleSelection = false
        picker?.headerBackgroundColor = headerBackgroundColor
        
        loadSettings(picker)
        
        picker?.show()
    }
    
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return self.MeatTimeNames.count
        } else {
            return self.DairyTimeNames.count
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        if pickerView.tag == 0 {
            return self.MeatTimeNames[row]
        } else {
            return self.DairyTimeNames[row]
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
         NSLog("Clicked \(row)")
        if pickerView.tag == 0 {
            //meat
            let value = self.MeatTimeNames[row];
            PZSettingsManager.sharedInstance.currentMeatMinhag = PZMeatWaitMinhag(rawValue: value)!
        } else {
            //dairy
            let value = self.DairyTimeNames[row];
            PZSettingsManager.sharedInstance.currentDairyMinhag = PZDairyWaitMinhag(rawValue: value)!
        }
        PZSettingsManager.sharedInstance.savePZSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.backgroundColor = PZUtils.sharedInstance.flatGrayColor
        self.navigationController!.navigationBar.barTintColor = PZUtils.sharedInstance.flatGrayColor
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //Save!
        PZSettingsManager.sharedInstance.savePZSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSettings(_ picker: CZPickerView!) {
        PZSettingsManager.sharedInstance.loadPZSettings()
        let meatIndex: Int = MeatTimeNames.find { $0 == PZSettingsManager.sharedInstance.currentMeatMinhag.rawValue }!
        
        let dairyIndex: Int = DairyTimeNames.find { $0 == PZSettingsManager.sharedInstance.currentDairyMinhag.rawValue }!
        
       if picker.tag == 0 {
            picker.setSelectedRows([meatIndex])
        } else if picker.tag == 1 {
            picker.setSelectedRows([dairyIndex])
        }
        
    }
    
    func configureTableView() {
        let tableHeight = view.frame.height - self.navigationController!.navigationBar.frame.height
        tableView.rowHeight = tableHeight / CGFloat(NavItems.buttons.count)
        tableView.estimatedRowHeight = 160.0
    }
    
}
