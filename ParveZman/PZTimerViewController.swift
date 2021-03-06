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
import GaugeKit

class PZTimerViewController: UIViewController   {
    
    @IBOutlet weak var parveLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerAtLabel: UILabel!
    @IBOutlet weak var timerGauge: Gauge!
    
    //variables
    var endTime = TimeInterval()
    var timer = Timer()
    var timerUUID: String = ""
    
    var type = ""
    var setLocalNotification: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let aSelector : Selector = #selector(PZTimerViewController.updateTime)
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        if self.setLocalNotification {
            setupLocalNotification()
        }
        
        //save timer        
        let timerManager = PZTimerManager()
        timerManager.savePZTimer(self.endTime, timerType: self.type)
        
        self.title = "Timer"
    }
    
    func setupLocalNotification() {
        //init the uuid
        self.timerUUID = UUID().uuidString
        
        //init the notification
        let notification = UILocalNotification()
        notification.alertBody = "Congrats, you're now Parve!"
        notification.alertTitle = "Parve Zman!"
        notification.fireDate = Date(timeIntervalSinceReferenceDate: self.endTime)
        notification.soundName = UILocalNotificationDefaultSoundName // default sound
        notification.userInfo = [ "UUID" : timerUUID ]
        notification.category = "PARVE_CATEGORY"
        
        //schedule it
        UIApplication.shared.scheduleLocalNotification(notification)

    }

    override func viewWillAppear(_ animated: Bool) {
        var color: UIColor
        
        if self.type == "meat" {
            color = PZUtils.sharedInstance.flatRedColor
            self.title = "Meat Timer"
        } else {
            color = PZUtils.sharedInstance.flatBlueColor
            self.title = "Dairy Timer"
        }
        self.setupNavigationBar(color)
        self.setupGauge(color)
    }
    
    func setupNavigationBar(_ color: UIColor) {
        self.navigationController!.navigationBar.backgroundColor = color
        self.navigationController!.navigationBar.barTintColor = color
        
        self.navigationController!.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(24.0))
        ]
    }
    
    func setupGauge(_ color: UIColor){
        self.timerGauge.startColor = color
        self.timerGauge.endColor = PZUtils.sharedInstance.flatGreenColor
        
        //set the max value as the minutes of the minhag
        var maxTime: TimeInterval
        if self.type == "meat" {
           maxTime = PZMinhag.GetTimeFromMinhag(PZSettingsManager.sharedInstance.currentMeatMinhag)
        } else {
           maxTime = PZMinhag.GetTimeFromMinhag(PZSettingsManager.sharedInstance.currentDairyMinhag)
        }
        
        self.timerGauge.maxValue = CGFloat(maxTime / 60.0)
        self.timerGauge.rate = CGFloat(maxTime / 60.0)
        self.timerGauge.reverse = true
    }
    
    func updateTime() {
        if !self.timer.isValid {
            return
        }
        
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and end time.
        
        var elapsedTime: TimeInterval = self.endTime - currentTime
        
        if elapsedTime <= 0 {
            return timerDidEnd(self.timer)
        }
        
        self.timerGauge.rate = CGFloat(elapsedTime / 60.0)
        
        //calculate the hours in elapsed time.
        
        let hours = UInt8(elapsedTime / 60.0 / 60.0)
        
        elapsedTime -= TimeInterval(CDouble(hours) * 3600)
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= TimeInterval(CDouble(minutes) * 60)
        
        //seconds to be displayed.
        
        let seconds = UInt8(elapsedTime)
        
        //add the leading zeros and store them as string constants
        
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate hours, minutes, seconds and assign it to the UILabel
        
        self.timerLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
        
    }
    
    func timerDidEnd(_ timer: Timer) {
        timer.invalidate()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        self.timerLabel.text = "Parve Zman!"
        
        //Set the gauge to green
        self.timerGauge.startColor = PZUtils.sharedInstance.flatGreenColor
        self.timerGauge.maxValue = 1
        self.timerGauge.rate = 1
    }
    
    override func navigationShouldPopOnBackButton() -> Bool {
        //Check if the timer is finished
        if !self.timer.isValid {
            return true
        }
        
        //Confirm
        let alert = SCLAlertView()
        alert.showCloseButton = false
        alert.addButton("Yes"){
            self.navigationController!.popViewController(animated: true)
            return
        }
        alert.addButton("No"){
            return
        }
        
        alert.showWarning("Cancel Timer?", subTitle: "Cancel current timer and all notifications?")
        
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
        
        //clear the timer
        let timerManager = PZTimerManager()
        timerManager.clearPZTimer()
        
        //cancel the notification
        for notification in (UIApplication.shared.scheduledLocalNotifications as [UILocalNotification]?)! { // loop through notifications...
            if (notification.userInfo!["UUID"] as! String == self.timerUUID) { // ...and cancel the notification when you find it...
                UIApplication.shared.cancelLocalNotification(notification)
                break
            }
        }
        
        //quit the view
        super.viewWillDisappear(animated)
    }
    
}
