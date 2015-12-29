//
//  PZTimer.swift
//  ParveZman
//
//  Created by Zachary Leighton on 12/27/15.
//  Copyright © 2015 Zachary Leighton. All rights reserved.
//

import Foundation
import CoreData

class PZTimer: NSManagedObject {
    
    @NSManaged var endTime: NSDate
    @NSManaged var timerType: String
    @NSManaged var id: Int16
    
}
