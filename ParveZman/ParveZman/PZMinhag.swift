//
//  PZMinhag.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/7/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import Foundation

class PZMinhag {
 
    static func GetAllMeatNames() -> Array<String> {
        var meatMinhagArray = [String]()
        
        for minhag in PZMeatWaitMinhag.allValues {
            meatMinhagArray.append(minhag.rawValue)
        }
        return meatMinhagArray
    }
    
    static func GetAllDairyNames() -> Array<String> {
        var dairyMinhagArray = [String]()
        
        for minhag in PZDairyWaitMinhag.allValues {
            dairyMinhagArray.append(minhag.rawValue)
        }
        return dairyMinhagArray
    }
    
    static func GetTimeFromMinhag(meatMinhag: PZMeatWaitMinhag) -> NSTimeInterval {
        var minutes: Int = 0
        
        switch meatMinhag {
        case .TwentyFourHours:
            minutes = 24*60
        case .SixFullHours:
            minutes = 6*60
        case .SixthHour:
            minutes = (5*60)+1
        //case .FourHalachicHours:
            //minutes = PZHalachicHelper.sharedInstance.CalculateHalachicHoursToMinutes(4.0);
        case .ThreeHours:
            minutes = 3*60
        case .OneHour:
            minutes = 60
        case .None:
            minutes = 0
        //Test
        case .Test:
            minutes = 1
        //EndTest
        default:
            minutes = 0
        }
        
        
        let waitTime: NSTimeInterval = NSTimeInterval(minutes * 60)
        return waitTime
        
    }
    
    static func GetTimeFromMinhag(dairyMinhag: PZDairyWaitMinhag) -> NSTimeInterval {
        var minutes = 0
        
        switch dairyMinhag {
        case .OneHour:
            minutes = 60
        case .None:
            minutes = 0
        //Test
        case .Test:
            minutes = 1
        //EndTest
        default:
            minutes = 0
        }
        
        let waitTime: NSTimeInterval = NSTimeInterval(minutes * 60)
        return waitTime
    }
}

//enum for milchig and fleishig
enum PZMeatWaitMinhag : String {
    case TwentyFourHours = "24 Hours"
    case SixFullHours = "6 Hours"
    case SixthHour = "6th Hour"
    //case FourHalachicHours = "4 Halachic Hours"
    case ThreeHours = "3 Hours"
    case OneHour = "1 Hour"
    case None = "None"
    //Test
    case Test = "Test"
    //EndTest
    
    static let allValues = [TwentyFourHours, SixFullHours, SixthHour, ThreeHours, OneHour, None //,FourHalachicHours
        //Test
        ,Test
        //EndTest
    ]
}

enum PZDairyWaitMinhag : String {
    case OneHour = "1 Hour"
    case None = "None"
    //Test
    case Test = "Test"
    //EndTest
    
    static let allValues = [OneHour, None
        //Test
        ,Test
        //EndTest
    ]
}