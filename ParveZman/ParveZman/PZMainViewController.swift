//
//  PZMainViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/1/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import UIKit
import CoreLocation

class PZMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Parve Zman";
        
        
        //Get Location
        var locManager = CLLocationManager();
        locManager.requestWhenInUseAuthorization();
        
        //Check Authorization of Location
        var currentLocation : CLLocation!;
        var authorized : Bool;
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                NSLog("Got authorization to use location");
                currentLocation = locManager.location;
                authorized = true;
        } else {
            NSLog("Did not get location auth");
            authorized = false;
        }
        
        //Get TimeZone
        var timeZone = NSTimeZone.systemTimeZone();
        NSLog("TimeZone: %@", timeZone.name);
        
        
        
        //sunInfo.local

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var locManager = CLLocationManager();
        locManager.requestWhenInUseAuthorization();
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
