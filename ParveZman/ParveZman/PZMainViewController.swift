//
//  PZMainViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/1/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import UIKit
import CoreLocation
import JTImageButton
import UIColor_Hex_Swift

class PZMainViewController: UIViewController, CLLocationManagerDelegate {

    
    //Buttons
    @IBOutlet weak var meatButton: JTImageButton!
    @IBOutlet weak var dairyButton: JTImageButton!
    @IBOutlet weak var settingsButton: JTImageButton!
    
    //Location
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!

    //Subroutines
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Parve Zman";
        
        //Location stuff
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation()
        startLocation = nil;
        meatButton.tag = 0;
        dairyButton.tag = 1;
        
        //Load from core data if possible
        PZSettingsManager.sharedInstance.loadPZSettings()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //create colors
        //red
        var flatRedColor: UIColor = UIColor.colorWithCSS("#F2362C")
        //blue
        var flatBlueColor: UIColor = UIColor.colorWithCSS("#1A7CF9")
        //gray
        var flatGrayColor: UIColor = UIColor.colorWithCSS("#A9A9A9")
        
        //setup buttons
        //meat
        self.meatButton.createTitle("I Ate Meat", withIcon: UIImage(named: "Steak"), font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.meatButton.titleColor = flatRedColor
        self.meatButton.iconColor = flatRedColor
        self.meatButton.borderColor = flatRedColor
        self.meatButton.bgColor = UIColor.whiteColor()
        self.meatButton.borderWidth = 3.0
        self.meatButton.cornerRadius = 50.0
        self.meatButton.sizeToFit()
        
        //dairy
        self.dairyButton.createTitle("I Ate Dairy", withIcon: UIImage(named: "Cheese"), font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.dairyButton.titleColor = flatBlueColor
        self.dairyButton.iconColor = flatBlueColor
        self.dairyButton.borderColor = flatBlueColor
        self.dairyButton.bgColor = UIColor.whiteColor()
        self.dairyButton.borderWidth = 3.0
        self.dairyButton.cornerRadius = 50.0
        self.dairyButton.sizeToFit()
        
        //settings
        self.settingsButton.createTitle("Settings", withIcon: UIImage(named: "Settings"), font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.settingsButton.titleColor = flatGrayColor
        self.settingsButton.iconColor = flatGrayColor
        self.settingsButton.borderColor = flatGrayColor
        self.settingsButton.bgColor = UIColor.whiteColor()
        self.settingsButton.borderWidth = 3.0
        self.settingsButton.cornerRadius = 50.0
        self.settingsButton.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var latestLocation: AnyObject = locations[locations.count - 1];
        
        if startLocation == nil {
            startLocation = latestLocation as! CLLocation;
        }
        
        PZHalachicHelper.sharedInstance.locationEnabled = true;
        PZHalachicHelper.sharedInstance.updateHalachicTimesByLocation(latestLocation as! CLLocation);
        
        NSLog("Halachic Times Updated!");
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
            
        //Display a warning and mark it in the halachic helper that we're using the default
        
            PZHalachicHelper.sharedInstance.locationEnabled = false;
    }
    
    //Button actions
    
    @IBAction func timerStart(sender: AnyObject) {
        //check if we're in timer mode currently?
        
        //get the time
        let button = sender as! UIButton;
        var time: Double
        if button.tag == 0 {
            time = PZMinhag.GetTimeFromMinhag(PZSettingsManager.sharedInstance.currentMeatMinhag)
        } else {
            time = PZMinhag.GetTimeFromMinhag(PZSettingsManager.sharedInstance.currentDairyMinhag)
        }
        
        //get the timer view
        var pzTimerViewController = storyboard!.instantiateViewControllerWithIdentifier("PZTimerViewController") as! PZTimerViewController
        
        //pass the view controller all the information it needs here
        pzTimerViewController.endTime = NSDate.timeIntervalSinceReferenceDate() + time
        
        self.presentViewController(pzTimerViewController, animated: true, completion: nil)
        
        return
        
    }
    
    //show settings
    @IBAction func showSettings(sender: AnyObject) {
        //get the timer view
        var pzSettingsViewController = storyboard!.instantiateViewControllerWithIdentifier("PZSettingsViewController") as! PZSettingsViewController
        
        self.presentViewController(pzSettingsViewController, animated: true, completion: nil)
        
        return

    }
}
