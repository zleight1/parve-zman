//
//  PZMainViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/1/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import UIKit
import CoreLocation

class PZMainViewController: UIViewController, CLLocationManagerDelegate {

    
    //Buttons
    @IBOutlet weak var meatButton: UIButton!
    @IBOutlet weak var dairyButton: UIButton!
    
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
