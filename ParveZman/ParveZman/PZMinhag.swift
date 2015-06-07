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
        var meatMinhagArray = [String]();
        
        for minhag in PZMeatWaitMinhag.allValues {
            meatMinhagArray.append(minhag.rawValue);
        }
        return meatMinhagArray;
    }
    
    static func GetAllDairyNames() -> Array<String> {
        var dairyMinhagArray = [String]();
        
        for minhag in PZDairyWaitMinhag.allValues {
            dairyMinhagArray.append(minhag.rawValue);
        }
        return dairyMinhagArray;
    }
}

//enum for milchig and fleishig
enum PZMeatWaitMinhag : String {
    case TwentyFourHours = "24 Hours"
    case SixFullHours = "6 Hours"
    case SixthHour = "6th Hour"
    case FourHalachicHours = "4 Halachic Hours"
    case ThreeHours = "3 Hours"
    case OneHour = "1 Hour"
    case None = "None"
    
    static let allValues = [TwentyFourHours, SixFullHours, SixthHour, FourHalachicHours, ThreeHours, OneHour, None]
}

enum PZDairyWaitMinhag : String {
    case OneHour = "1 Hour"
    case None = "None"
    
    static let allValues = [OneHour, None]
}