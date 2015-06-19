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
        self.currentDairyMinhag = PZDairyWaitMinhag.None;
        self.currentMeatMinhag = PZMeatWaitMinhag.SixFullHours;
    }
    
    //Properties
    var currentDairyMinhag: PZDairyWaitMinhag;
    var currentMeatMinhag: PZMeatWaitMinhag;
}
