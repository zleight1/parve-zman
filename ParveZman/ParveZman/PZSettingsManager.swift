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
        let appDelegate = AppDelegate().appDelegate()
        
        let managedContext = appDelegate.managedObjectContext!
        
        if let PZSettings = loadPZSettingsData() {
            
            PZSettings.setValue(self.currentMeatMinhag.rawValue, forKey: "meatMinhag")
            PZSettings.setValue(self.currentDairyMinhag.rawValue, forKey: "dairyMinhag")
            
            do {
                try managedContext.save()
            } catch _ {
            }
            
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
            do {
                try managedContext.save()
                NSLog("Settings Saved.")
            } catch let error1 as NSError {
                error = error1
                NSLog("Could not save \(error), \(error?.userInfo)")
            }
        }
        
    }
    
    func loadPZSettings() {
        if let PZSettings = loadPZSettingsData() {
            let dairyMinhag = PZSettings.valueForKey("dairyMinhag") as! String
            let meatMinhag = PZSettings.valueForKey("meatMinhag") as! String
            
            NSLog("%@ %@", dairyMinhag, meatMinhag)
            PZSettingsManager.sharedInstance.currentMeatMinhag = PZMeatWaitMinhag(rawValue: meatMinhag)!
            PZSettingsManager.sharedInstance.currentDairyMinhag = PZDairyWaitMinhag(rawValue: dairyMinhag)!
        }
    }
    
    func loadPZSettingsData() -> NSManagedObject? {
        let appDelegate = AppDelegate().appDelegate()
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("PZSettings", inManagedObjectContext: managedContext)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        
        let pred = NSPredicate(format: "(id = 1)")
        fetchRequest.predicate = pred
        
        var error: NSError?
        
        let fetchedResults: [AnyObject]?
        do {
            fetchedResults = try managedContext.executeFetchRequest(fetchRequest)
        } catch let error1 as NSError {
            error = error1
            fetchedResults = nil
        }
        
        if let results = fetchedResults {
            //unwrap the results, Happy Channukah!
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                NSLog("%@", match);
                return match
            }
            NSLog("%@", fetchedResults!)
        } else {
            print("Could not fetch \(error), \(error!.userInfo)")
        }
        return nil
    }
}
