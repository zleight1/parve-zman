//
//  ParveZmanSettings.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/7/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import Foundation

class PZSettings {
    static let sharedInstance = PZSettings();
    
    //Initialize the settings
    init() {
        
    }
    
}

//enum for milchig and fleishig
enum PZMeatWaitMinhag {
    case TwentyFourHours
    case SixFullHours
    case SixthHour
    case FourHalachicHours
    case ThreeHours
    case OneHour
    case None
}

enum PZDairyWaitMinhag {
    case OneHour
    case None
}