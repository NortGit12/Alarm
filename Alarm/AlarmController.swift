//
//  AlarmController.swift
//  Alarm
//
//  Created by Jeff Norton on 7/5/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

protocol AlarmScheduler {
    
    func scheduleLocalNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
    
}

extension AlarmScheduler {
    
    func scheduleLocalNotification(alarm: Alarm) {
        
        guard let timerTimeInterval = alarm.fireDate?.timeIntervalSinceNow else { return }
        
        let localNotification = UILocalNotification()
        
        localNotification.category = "alarms_basic"
        localNotification.alertTitle = "Title: Alarm"
        localNotification.alertBody = "Body: \(alarm.name)"
        localNotification.alertAction = "Action: Go to alarm"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: timerTimeInterval)
        localNotification.repeatInterval = NSCalendarUnit.Day
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
    }
    
    func cancelLocalNotification(alarm: Alarm) {
        
        // Get an array of all of the Notifications
        guard let localNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        
        // Get a filtered array of only Alarm Notifications
        let alarmNotifications = localNotifications.filter( { $0.category == "alarms_basic" } )
        
        // Cancel the Alarm Notifications
        for notification in alarmNotifications {
            
            UIApplication.sharedApplication().cancelLocalNotification(notification)
            
        }
        
    }
    
}

class AlarmController {
    
    // MARK: - Stored Properties
    
    var alarms: [Alarm] = []
    
    private let alarmsKey = "alarmsKey"
    
    static let sharedController = AlarmController()
    
    var mockAlarms: [Alarm] {
        
        let wakeUpAlarm = Alarm(fireTimeFromMidnight: NSTimeInterval(21600), name: "Wake Up", enabled: true)
        let leaveForSchoolAlarm = Alarm(fireTimeFromMidnight: NSTimeInterval(28800), name: "Leave for School", enabled: false)
        let lunchAlarm = Alarm(fireTimeFromMidnight: NSTimeInterval(43200), name: "Lunchtime", enabled: true)
        let goToSleepAlarm = Alarm(fireTimeFromMidnight: NSTimeInterval(79200), name: "Go to sleep", enabled: false)
        
        return [wakeUpAlarm, leaveForSchoolAlarm, lunchAlarm, goToSleepAlarm]
        
    }
    
    // MARK: - Initializer(s)
    
    init() {
        
        //self.alarms = self.mockAlarms
        loadFromPersistentStore()
        
    }
    
    // MARK: - Methods
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String, isEnabled: Bool) -> Alarm {
        
        // Create alarm
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name, enabled: isEnabled)
        
        // Add the alarm to the alarms array
        alarms.append(alarm)
        
        // Save
        saveToPersistentStore()
        
        // Return the alarm
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String, isEnabled: Bool) {
        
        guard let index = alarms.indexOf(alarm) where name.characters.count > 0 else {
            return
        }
        
        alarms[index].fireTimeFromMidnight = fireTimeFromMidnight
        alarms[index].name = name
        alarms[index].enabled = isEnabled
        
        // Save
        saveToPersistentStore()
        
    }
    
    func deleteAlarm(alarm: Alarm) {
        
        guard let index = alarms.indexOf(alarm) else {
            return
        }
        
        alarms.removeAtIndex(index)
        
        // Save
        saveToPersistentStore()
        
    }
    
    func toggleEnabled(alarm: Alarm) {
        
        if let index = alarms.indexOf(alarm) {
            
            switch alarm.enabled {
            case true: alarms[index].enabled = false
            case false: alarms[index].enabled = true
            }
        }
        
        // Save
        saveToPersistentStore()
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
    
    func saveToPersistentStore() {
        
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: self.filePath(alarmsKey))
        
    }
    
    func loadFromPersistentStore() {
        
        guard let alarmsArray = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(alarmsKey)) as? [Alarm] else { return }
        
        alarms = alarmsArray
        
    }
    
}