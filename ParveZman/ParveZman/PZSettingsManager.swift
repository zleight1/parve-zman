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
        
        if let PZSettings = loadPZSettingsData() {
            
            PZSettings.setValue(self.currentMeatMinhag.rawValue, forKey: "meatMinhag")
            PZSettings.setValue(self.currentDairyMinhag.rawValue, forKey: "dairyMinhag")
            
            managedContext.save(nil)
            
        } else {
            
            let entityDescription =  NSEntityDescription.entityForName("PZSettings",
                inManagedObjectContext:
                managedContext)
            
            let settings = NSManagedObject(entity: entityDescription!,
                insertIntoManagedObjectContext:managedContext)
            
            
            settings.setValue(self.currentMeatMinhag.rawValue, forKey: "meatMinhag")
            settings.setValue(self.currentDairyMinhag.rawValue, forKey: "dairyMinhag")
            settings.setValue(1, forKey: "id")
            
            var error: NSError?
            if !managedContext.save(&error) {
                NSLog("Could not save \(error), \(error?.userInfo)")
            } else {
                NSLog("Settings Saved.")
            }
        }
        
    }
    
    func loadPZSettings() {
        if let PZSettings = loadPZSettingsData() {
            var dairyMinhag = PZSettings.valueForKey("dairyMinhag") as! String
            var meatMinhag = PZSettings.valueForKey("meatMinhag") as! String
            
            NSLog("%@ %@", dairyMinhag, meatMinhag)
            PZSettingsManager.sharedInstance.currentMeatMinhag = PZMeatWaitMinhag(rawValue: meatMinhag)!
            PZSettingsManager.sharedInstance.currentDairyMinhag = PZDairyWaitMinhag(rawValue: dairyMinhag)!
        }
    }
    
    func loadPZSettingsData() -> NSManagedObject? {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("PZSettings", inManagedObjectContext: managedContext)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        
        let pred = NSPredicate(format: "(id = 1)")
        fetchRequest.predicate = pred
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error)
        
        if let results = fetchedResults {
            //unwrap the results, Happy Channukah!
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                NSLog("%@", match);
                return match
            }
            NSLog("%@", fetchedResults!)
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        return nil
    }
}
