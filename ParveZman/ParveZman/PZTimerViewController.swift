//
//  PZTimerViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 8/5/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import UIKit
import JTImageButton
import AudioToolbox
import SCLAlertView

class PZTimerViewController: UIViewController {
    
    @IBOutlet weak var parveLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerAtLabel: UILabel!
    @IBOutlet weak var stopTimerButton: JTImageButton!
    
    //variables
    var endTime = NSTimeInterval()
    var timer = NSTimer()
    var timerUUID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let aSelector : Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        //init the uuid
        self.timerUUID = NSUUID().UUIDString
        
        //init the notification
        let notification = UILocalNotification()
        notification.alertBody = "Congrats, you're now Parve!"
        notification.alertTitle = "Parve Zman!"
        notification.fireDate = NSDate(timeIntervalSinceReferenceDate: endTime)
        notification.soundName = UILocalNotificationDefaultSoundName // default sound
        notification.userInfo = [ "UUID" : timerUUID ]
        notification.category = "PARVE_CATEGORY"
        
        //schedule it
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        self.title = "Timer"
    }

    override func viewWillAppear(animated: Bool) {
        //create colors
        let flatRedColor: UIColor = UIColor.init(hexString: "#F2362C")
        
        //setup buttons
        //stop timer
        self.stopTimerButton.createTitle("", withIcon: UIImage(named: "Cancel"), font: nil, iconHeight: CGFloat(0.0), iconOffsetY: CGFloat(0.0))
        self.stopTimerButton.iconColor = UIColor.whiteColor()
        self.stopTimerButton.borderColor = flatRedColor
        self.stopTimerButton.bgColor = flatRedColor
        self.stopTimerButton.borderWidth = 3.0
        self.stopTimerButton.cornerRadius = 37.5
        self.stopTimerButton.sizeToFit()

    }
    
    func setParveEndTime(endTimeInterval: NSTimeInterval){
        
    }
    
    func updateTime() {
        if !self.timer.valid {
            return
        }
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and end time.
        
        var elapsedTime: NSTimeInterval = self.endTime - currentTime
        
        if elapsedTime <= 0 {
            return timerDidEnd(self.timer)
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
        
        self.timerLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
        
    }
    
    func timerDidEnd(timer: NSTimer) {
        timer.invalidate()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        self.timerLabel.text = "Parve Zman!"
    }
    
    @IBAction func stop(sender: AnyObject) {
        //Confirm
        let alert = SCLAlertView()
        alert.showCloseButton = false
        alert.addButton("Yes"){
            self.timer.invalidate()
            
            //cancel the notification
            for notification in (UIApplication.sharedApplication().scheduledLocalNotifications as [UILocalNotification]?)! { // loop through notifications...
                if (notification.userInfo!["UUID"] as! String == self.timerUUID) { // ...and cancel the notification when you find it...
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                    break
                }
            }
            
            //quit the view
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addButton("No"){
            return
        }
        
        alert.showWarning("Cancel Timer?", subTitle: "Cancel current timer and any scheduled alerts?")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
