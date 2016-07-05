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