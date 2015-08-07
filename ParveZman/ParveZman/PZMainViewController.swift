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

class PZMainViewController: UIViewController, CLLocationManagerDelegate {

    
    //Buttons
    @IBOutlet weak var meatButton: JTImageButton!
    @IBOutlet weak var dairyButton: JTImageButton!
    
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
        var flatRedColor: UIColor = UIColor(red: 231 / 255.0, green: 76 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        var flatBlueColor: UIColor = UIColor(red: 52 / 255.0, green: 152 / 255.0, blue: 219 / 255.0, alpha: 1.0)
        
        //setup buttons
        self.meatButton.createTitle("Meat", withIcon: nil, font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.meatButton.titleColor = flatRedColor
        self.meatButton.iconColor = flatRedColor
        self.meatButton.borderColor = flatRedColor
        self.meatButton.borderWidth = 2.0
        self.meatButton.sizeToFit()
        
        self.dairyButton.createTitle("Dairy", withIcon: nil, font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.dairyButton.titleColor = flatBlueColor
        self.dairyButton.iconColor = flatBlueColor
        self.dairyButton.borderColor = flatBlueColor
        self.dairyButton.borderWidth = 2.0
        self.dairyButton.sizeToFit()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
