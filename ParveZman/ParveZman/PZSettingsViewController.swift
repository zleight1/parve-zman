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

class PZSettingsViewController: UIViewController {
    
    var MeatTimeNames = PZMinhag.GetAllMeatNames();
    var DairyTimeNames = PZMinhag.GetAllDairyNames();
    
    var tempMeatWaitMinhag = PZSettingsManager.sharedInstance.currentMeatMinhag
    var tempDairyWaitMinhag = PZSettingsManager.sharedInstance.currentDairyMinhag
    
    var settingsChanged = false
    
    @IBOutlet weak var meatMinhagPicker: UIPickerView!
    @IBOutlet weak var dairyMinhagPicker: UIPickerView!
    
    @IBOutlet weak var cancelButton: JTImageButton!
    @IBOutlet weak var saveButton: JTImageButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Settings";
        
        loadSettings()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //create colors
        //red
        let flatRedColor: UIColor = UIColor.init(hexString: "#F2362C")
        //green
        let flatGreenColor: UIColor = UIColor.init(hexString: "#76EE00")
        
        //setup buttons
        //cancel
        self.cancelButton.createTitle("", withIcon: UIImage(named: "Cancel"), font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.cancelButton.iconColor = UIColor.whiteColor()
        self.cancelButton.borderColor = flatRedColor
        self.cancelButton.bgColor = flatRedColor
        self.cancelButton.borderWidth = 3.0
        self.cancelButton.cornerRadius = 37.5
        self.cancelButton.sizeToFit()
        
        //save
        self.saveButton.createTitle("", withIcon: UIImage(named: "Accept"), font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.saveButton.iconColor = UIColor.whiteColor()
        self.saveButton.borderColor = flatGreenColor
        self.saveButton.bgColor = flatGreenColor
        self.saveButton.borderWidth = 3.0
        self.saveButton.cornerRadius = 37.5
        self.saveButton.sizeToFit()
    }
    
    override func viewDidDisappear(animated: Bool) {
        //Save!
        PZSettingsManager.sharedInstance.savePZSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return self.MeatTimeNames.count
        } else {
            return self.DairyTimeNames.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0 {
            return self.MeatTimeNames[row]
        } else {
            return self.DairyTimeNames[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 0 {
            //meat
            let value = self.MeatTimeNames[row];
            self.tempMeatWaitMinhag = PZMeatWaitMinhag(rawValue: value)!
        } else {
            //dairy
            let value = self.DairyTimeNames[row];
            self.tempDairyWaitMinhag = PZDairyWaitMinhag(rawValue: value)!
        }
        settingsChanged = true
    }
    
    func loadSettings() {
        PZSettingsManager.sharedInstance.loadPZSettings()
        let meatIndex: Int = MeatTimeNames.find { $0 == PZSettingsManager.sharedInstance.currentMeatMinhag.rawValue }!
        meatMinhagPicker.selectRow(meatIndex, inComponent: 0, animated: false)
        
        let dairyIndex: Int = DairyTimeNames.find { $0 == PZSettingsManager.sharedInstance.currentDairyMinhag.rawValue }!
        dairyMinhagPicker.selectRow(dairyIndex, inComponent: 0, animated: false)
    }
    
    func saveSettings() {
        PZSettingsManager.sharedInstance.currentMeatMinhag = self.tempMeatWaitMinhag
        PZSettingsManager.sharedInstance.currentDairyMinhag = self.tempDairyWaitMinhag
    }
    
    @IBAction func acceptClicked(sender: AnyObject) {
        saveSettings()
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        //bail out if settings haven't changed
        if(!settingsChanged) {
            self.dismissViewControllerAnimated(false, completion: nil)
            return
        }
        
        let alert = SCLAlertView()
        alert.showCloseButton = false
        alert.addButton("Yes"){
             self.dismissViewControllerAnimated(false, completion: nil)
             return
        }
        alert.addButton("No"){
            return
        }
        
        alert.showWarning("Discard Changes?", subTitle: "Discard any changes made to minhag settings?")
    }
    
    
}
