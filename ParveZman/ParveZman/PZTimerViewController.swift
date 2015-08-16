//
//  PZTimerViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 8/5/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import UIKit
import JTImageButton

class PZTimerViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var stopTimerButton: JTImageButton!
    
    //variables
    var endTime = NSTimeInterval()
    var timer = NSTimer()
    var timerUUID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        //init the uuid
        timerUUID = NSUUID().UUIDString
        
        //init the notification
        var notification = UILocalNotification()
        notification.alertBody = "Congrats, you're now Parve!"
        notification.alertTitle = "Parve Zman!"
        notification.fireDate = NSDate(timeIntervalSinceReferenceDate: endTime)
        notification.soundName = UILocalNotificationDefaultSoundName // default sound
        notification.userInfo = [ "UUID" : timerUUID ]
        notification.category = "PARVE_CATEGORY"
        
        //schedule it
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    override func viewWillAppear(animated: Bool) {
        //create colors
        var flatRedColor: UIColor = UIColor.colorWithCSS("#F2362C")
        
        //setup buttons
        //stop timer
        self.stopTimerButton.createTitle("", withIcon: UIImage(named: "Cancel"), font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.stopTimerButton.titleColor = flatRedColor
        self.stopTimerButton.iconColor = flatRedColor
        self.stopTimerButton.borderColor = flatRedColor
        self.stopTimerButton.bgColor = UIColor.whiteColor()
        self.stopTimerButton.borderWidth = 3.0
        self.stopTimerButton.cornerRadius = 37.5
        self.stopTimerButton.sizeToFit()

    }
    
    func updateTime() {
        if !timer.valid {
            return
        }
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and end time.
        
        var elapsedTime: NSTimeInterval = endTime - currentTime
        
        if elapsedTime <= 0 {
            return
        }
        
        //calculate the hours in elapsed time.
        
        let hours = UInt8(elapsedTime / 60.0 / 60.0)
        
        elapsedTime -= NSTimeInterval(CDouble(hours) * 3600)
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= NSTimeInterval(CDouble(minutes) * 60)
        
        //seconds to be displayed.
        
        let seconds = UInt8(elapsedTime)
        
        //add the leading zeros and store them as string constants
        
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate hours, minutes, seconds and assign it to the UILabel
        
        timerLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
        
    }
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
        
        //cancel the notification
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification] { // loop through notifications...
            if (notification.userInfo!["UUID"] as! String == timerUUID) { // ...and cancel the notification when you find it...
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
        
        //quit the view
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
