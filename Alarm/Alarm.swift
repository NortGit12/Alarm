//
//  Alarm.swift
//  Alarm
//
//  Created by James Pacheco on 5/6/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Alarm: NSObject, NSCoding {
    
    var fireTimeFromMidnight: NSTimeInterval
    var name: String
    var enabled: Bool
    let uuid: String
    
    private let fireTimeFromMidnightKey = "fireTimeFromMidnightKey"
    private let nameKey = "nameKey"
    private let enabledKey = "enabledKey"
    private let uuidKey = "uuidKey"
    
    init(fireTimeFromMidnight: NSTimeInterval, name: String, enabled: Bool, uuid: String = NSUUID().UUIDString) {
        
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
        
    }
    
    var fireDate: NSDate? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return nil}
        let fireDateFromThisMorning = NSDate(timeInterval: fireTimeFromMidnight, sinceDate: thisMorningAtMidnight)
            return fireDateFromThisMorning
    }
    
    var fireTimeAsString: String {
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        var hours = fireTimeFromMidnight/60/60
        let minutes = (fireTimeFromMidnight - (hours*60*60))/60
        
        if hours >= 13 {
            return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", arguments: [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }
    
    
    // MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let fireTimeFromMidnight = aDecoder.decodeObjectForKey("fireTimeFromMidnightKey") as? NSTimeInterval
            , name = aDecoder.decodeObjectForKey("nameKey") as? String
            , enabled = aDecoder.decodeObjectForKey("enabledKey") as? Bool
            , uuid = aDecoder.decodeObjectForKey("uuidKey") as? String else { return nil }
        
        self.init(fireTimeFromMidnight: fireTimeFromMidnight, name: name, enabled: enabled, uuid: uuid)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(fireTimeFromMidnight, forKey: fireTimeFromMidnightKey)
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(enabled, forKey: enabledKey)
        aCoder.encodeObject(uuid, forKey: uuidKey)
        
    }
}

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}