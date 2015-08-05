//
//  PZHalachicHelper.swift
//  ParveZman
//
//  Created by Zachary Leighton on 27 Sivan 5775.
//  Copyright (c) 5775 Zachary Leighton. All rights reserved.
//

import Foundation
import CoreLocation

class PZHalachicHelper {
    static let sharedInstance = PZHalachicHelper();
    
    init() {
        self.currentHalachicHour =  1.0;
        self.locationEnabled  = true;
    }
    
    var currentHalachicHour : Double;
    var locationEnabled : Bool;
    
    func updateHalachicTimesByLocation(latestLocation: CLLocation) {
//        var location: KCGeoLocation = KCGeoLocation(latitude: latestLocation.coordinate.latitude, andLongitude: latestLocation.coordinate.longitude, andTimeZone: NSTimeZone.localTimeZone());
//
//        NSLog("%@", NSTimeZone.localTimeZone());
//
//        var calendar: KCAstronomicalCalendar = KCAstronomicalCalendar(location: location);
//        var sunrise: NSDate! = calendar.sunrise();
//        var sunset: NSDate! = calendar.sunset();
//
//        NSLog("Sunrise %@ Sunset %@", calendar.sunrise(), calendar.sunset());
//
//
//        // var sunriseSet = EDSunriseSet.sunrisesetWithTimezone(NSTimeZone.localTimeZone(), latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude);
//
//        var dayTimeInterval: NSTimeInterval = sunset.timeIntervalSinceDate(sunrise);
//        NSLog("Time Interval %f", dayTimeInterval);
//
        self.currentHalachicHour = 1.0 //CDouble(((dayTimeInterval/60)/60)/12);
//        
        NSLog("Current Halachic Hour : %f in minutes : %f", self.currentHalachicHour, self.currentHalachicHour * 60);
        
    }
    
    func CalculateHalachicHoursToMinutes(hours: Double) -> Int {
        return Int(ceil(self.currentHalachicHour * hours * 60));
    }
}