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

class PZSettingsViewController: UIViewController, CZPickerViewDelegate, CZPickerViewDataSource {
    
    var MeatTimeNames = PZMinhag.GetAllMeatNames();
    var DairyTimeNames = PZMinhag.GetAllDairyNames();
    
    
    var settingsChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Settings";
        
        //loadSettings()
    }
    
    @IBAction func Tapped(sender: AnyObject) {
        var title = ""
        let tag = sender.view!!.tag
        
        //create colors
        var headerBackgroundColor: UIColor = UIColor.clearColor()
        let flatRedColor: UIColor = UIColor.init(hexString: "#F2362C")
        let flatGreenColor: UIColor = UIColor.init(hexString: "#76EE00")
        let flatBlueColor: UIColor = UIColor.init(hexString: "#1A7CF9")
        
        if tag == 0 {
            title = "Meat Minhag"
            headerBackgroundColor = flatRedColor
        } else if tag == 1 {
            title = "Dairy Minhag"
            headerBackgroundColor = flatBlueColor
        }
        
        let picker = CZPickerView(headerTitle: title, cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker.delegate = self
        picker.dataSource = self
        picker.needFooterView = true
        picker.tag = tag
        picker.allowMultipleSelection = false
        picker.headerBackgroundColor = headerBackgroundColor
        //picker.confirmButtonBackgroundColor = flatGreenColor
        
        loadSettings(picker)
        
        picker.show()
    }
    
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return self.MeatTimeNames.count
        } else {
            return self.DairyTimeNames.count
        }
    }
    
    func czpickerView(pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        if pickerView.tag == 0 {
            return self.MeatTimeNames[row]
        } else {
            return self.DairyTimeNames[row]
        }
    }
    
    func czpickerView(pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
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
    
    override func viewWillAppear(animated: Bool) {
        
        
        self.navigationController!.navigationBar.backgroundColor = UIColor.init(hexString: "#A9A9A9")
        self.navigationController!.navigationBar.barTintColor = UIColor.init(hexString: "#A9A9A9")
    }
    
    override func viewDidDisappear(animated: Bool) {
        //Save!
        PZSettingsManager.sharedInstance.savePZSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSettings(picker: CZPickerView!) {
        PZSettingsManager.sharedInstance.loadPZSettings()
        let meatIndex: Int = MeatTimeNames.find { $0 == PZSettingsManager.sharedInstance.currentMeatMinhag.rawValue }!
        
        let dairyIndex: Int = DairyTimeNames.find { $0 == PZSettingsManager.sharedInstance.currentDairyMinhag.rawValue }!
        
       if picker.tag == 0 {
            picker.setSelectedRows([meatIndex])
        } else if picker.tag == 1 {
            picker.setSelectedRows([dairyIndex])
        }
        
    }
}
