//
//  PZSettingsViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/7/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import Foundation
import UIKit

class PZSettingsViewController: UIViewController {
    
    var MeatTimeNames = PZMinhag.GetAllMeatNames();
    var DairyTimeNames = PZMinhag.GetAllDairyNames();
    
    @IBOutlet weak var meatMinhagPicker: UIPickerView!
    @IBOutlet weak var dairyMinhagPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Settings";
        //meatMinhagPicker.select(PZSettings.sharedInstance.currentMeatMinhag);
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
            return MeatTimeNames.count;
        } else {
            return DairyTimeNames.count;
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0 {
            return MeatTimeNames[row];
        } else {
            return DairyTimeNames[row];
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 0 {
            //meat
            PZSettings.sharedInstance.currentMeatMinhag = PZMeatWaitMinhag(rawValue: MeatTimeNames[row])!;
        } else {
            //dairy
            PZSettings.sharedInstance.currentDairyMinhag = PZDairyWaitMinhag(rawValue: DairyTimeNames[row])!;
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
