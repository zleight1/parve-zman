//
//  ParveZmanSettings.swift
//  ParveZman
//
//  Created by Zachary Leighton on 6/7/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import UIKit
import CoreData

class PZSettingsManager {
    static let sharedInstance = PZSettingsManager();
    
    //Initialize the settings
    init() {
        self.currentDairyMinhag = PZDairyWaitMinhag.None
        self.currentMeatMinhag = PZMeatWaitMinhag.SixFullHours
    }
    
    //Properties
    var currentDairyMinhag: PZDairyWaitMinhag;
    var currentMeatMinhag: PZMeatWaitMinhag;
    
    func savePZSettings() {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("PZSettings",
            inManagedObjectContext:
            managedContext)
        
        let settings = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        settings.setValue(self.currentMeatMinhag.rawValue, forKey: "meatMinhag")
        settings.setValue(self.currentDairyMinhag.rawValue, forKey: "dairyMinhag")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        NSLog("Settings Saved.")
    }
    
    func loadPZSettings() {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("PZSettings", inManagedObjectContext: managedContext)
        
        //let fetchRequest = NSFetchRequest(
        //fetchRequest.entity = entity
        //fetchRequest.returnsObjectsAsFaults = false
        
        //var error: NSError?
        
       // let fetchedResults =
        //managedContext.executeFetchRequest(fetchRequest,
        //    error: &error)
        
      //  if let results = fetchedResults {
        //    //unwrap the results
        //    NSLog("%@", fetchedResults!)
        //} else {
       //     println("Could not fetch \(error), \(error!.userInfo)")
       //  }
    }
}
