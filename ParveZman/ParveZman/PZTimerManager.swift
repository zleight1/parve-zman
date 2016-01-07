//
//  PZTimerManager.swift
//  ParveZman
//
//  Created by Zachary Leighton on 12/28/15.
//  Copyright © 2015 Zachary Leighton. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class PZTimerManager {
    
    func savePZTimer(timeToEnd: NSTimeInterval, timerType: String) {
        let appDelegate = AppDelegate().appDelegate()
        
        let managedContext = appDelegate.managedObjectContext!
        
        //create end time
        let endTime = NSDate(timeIntervalSinceReferenceDate: timeToEnd)
        
        if let _ = loadPZTimerData() {
            self.clearPZTimer()
        }
        
        let entityDescription =  NSEntityDescription.entityForName("PZTimer",
            inManagedObjectContext:
            managedContext)
        
        let timer = NSManagedObject(entity: entityDescription!,
            insertIntoManagedObjectContext:managedContext)
        
        
        timer.setValue(endTime, forKey: "endTime")
        timer.setValue(timerType, forKey: "timerType")
        timer.setValue(1, forKey: "id")
        
        var error: NSError?
        do {
            try managedContext.save()
            NSLog("Timer Saved.")
        } catch let error1 as NSError {
            error = error1
            NSLog("Could not save \(error), \(error?.userInfo)")
        }
        
    }
    
    func isTimerActive() -> Bool {
        if let data = loadPZTimerData() {
            let endTime: NSDate = data.valueForKey("endTime") as! NSDate;
            //is is after now
            return endTime.timeIntervalSinceDate(NSDate()) > 0
            
        } else {
            return false
        }
    }
    
    func loadPZTimerData() -> NSManagedObject? {
        let appDelegate = AppDelegate().appDelegate()
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("PZTimer", inManagedObjectContext: managedContext)
        
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
    
    func clearPZTimer() {
        let appDelegate = AppDelegate().appDelegate()
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        let entity: NSEntityDescription = NSEntityDescription.entityForName("PZTimer", inManagedObjectContext: managedContext)!
        fetchRequest.entity = entity
        
        let fetchedResults: [AnyObject]?
        do {
            fetchedResults = try managedContext.executeFetchRequest(fetchRequest)
        } catch _ {
            //sink 'er cap'n
            fetchedResults = nil
        }
        
        if fetchedResults == nil {
            return
        }
        
        if let results = fetchedResults {
            //unwrap the results, Happy Channukah!
            if results.count > 0 {
                for currentObject in results {
                    managedContext.deleteObject(currentObject as! NSManagedObject)
                }
            }
        }
        
        
        do {
            try managedContext.save()
        } catch _ {
        }
    }
}
