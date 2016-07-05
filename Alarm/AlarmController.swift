//
//  AlarmController.swift
//  Alarm
//
//  Created by Jeff Norton on 7/5/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    
    // MARK: - Stored Properties
    
    var alarms: [Alarm] = []
    
    static let sharedController = AlarmController()
    
    var mockAlarms: [Alarm] {
        
        let wakeUpAlarm = Alarm(fireTimeFromMidnight: NSTimeInterval(21600), name: "Wake Up")
        let leaveForSchoolAlarm = Alarm(fireTimeFromMidnight: NSTimeInterval(28800), name: "Leave for School")
        let lunchAlarm = Alarm(fireTimeFromMidnight: NSTimeInterval(43200), name: "Lunchtime")
        let goToSleepAlarm = Alarm(fireTimeFromMidnight: NSTimeInterval(79200), name: "Go to sleep")
        
        lunchAlarm.enabled = false
        
        return [wakeUpAlarm, leaveForSchoolAlarm, lunchAlarm, goToSleepAlarm]
        
    }
    
    // MARK: - Initializer(s)
    
    init() {
        
        self.alarms = self.mockAlarms
        
    }
    
    // MARK: - Methods
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        
        // Create alarm
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        
        // Add the alarm to the alarms array
        alarms.append(alarm)
        
        // Return the alarm
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        
        guard let index = alarms.indexOf(alarm) where name.characters.count > 0 else {
            return
        }
        
        alarms[index].fireTimeFromMidnight = fireTimeFromMidnight
        alarms[index].name = name
        
    }
    
    func deleteAlarm(alarm: Alarm) {
        
        guard let index = alarms.indexOf(alarm) else {
            return
        }
        
        alarms.removeAtIndex(index)
        
    }
    
}