//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Jeff Norton on 7/5/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    // MARK: - Stored Properties
    
    var alarm: Alarm?
    
    let enableString = "Enable"
    let disableString = "Disable"
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    // MARK: - UITableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let alarm = alarm {
            updateWithAlarm(alarm)
        }
        
        setupView()
    }
    
    
    // MARK: - Methods
    
    func setupView() {
        
        if let alarm = alarm {
            switch alarm.enabled {
            case true:
                enableButton.setTitle(disableString, forState: .Normal)
                enableButton.backgroundColor = .redColor()
                enableButton.setTitleColor(.whiteColor(), forState: .Normal)
            case false:
                enableButton.setTitle(enableString, forState: .Normal)
                enableButton.backgroundColor = .greenColor()
                enableButton.setTitleColor(.whiteColor(), forState: .Normal)
            }
        } else {
            
            enableButton.setTitle(disableString, forState: .Normal)
            enableButton.backgroundColor = .redColor()
            enableButton.setTitleColor(.whiteColor(), forState: .Normal)
            
        }
    }
    
    func updateWithAlarm(alarm: Alarm) {
        
        guard let alarmFireDate = alarm.fireDate else { return }
        
        datePicker.date = alarmFireDate
        nameTextField.text = alarm.name
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func enableButtonTapped(sender: UIButton) {
        
        if let alarm = alarm {
            
            // Toggle the alarm's enabled property
            
            AlarmController.sharedController.toggleEnabled(alarm)
            
            /*
             * Schedule or cancel the alarm, based on what the value will be changed to.
             * If enabled is the following and then this button is tapped:
             *      * true  -> change to false and cancel the notification
             *      * false -> change to true and schedule the notification
             */
            
            switch alarm.enabled {
            case true:
                alarm.enabled = false
                cancelLocalNotification(alarm)
            case false:
                alarm.enabled = true
                scheduleLocalNotification(alarm)
            }
            
            setupView()
        }
    }
    
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        
        //guard let fireTimeInterval = datePicker?.date.timeIntervalSinceNow, name = nameTextField?.text else { return }
        guard let name = nameTextField?.text, thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        
        /*
         The logic here seems somewhat backwards.  When the label says "Enable" that means that the alarm
         is disabled and you can enable it and when the label says "Disable" that means that the alarm is
         enabled and you can disable it.
         */
        var isEnabled = false
        if enableButton.titleLabel?.text == enableString {
            isEnabled = false
        } else {
            isEnabled = true
        }
        
        if let alarm = alarm {
            
            // Existing alarm
            AlarmController.sharedController.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: name, isEnabled: isEnabled)
            
            // Cancel and reset the Notification
            cancelLocalNotification(alarm)
            scheduleLocalNotification(alarm)
            
        } else {
            
            // Debug shortcircuit
            //let fireTimeInterval = NSTimeInterval(5)
            
            // New alarm
            AlarmController.sharedController.addAlarm(timeIntervalSinceMidnight, name: name, isEnabled: isEnabled)
            
            
            // Schedule the Notification
            guard let alarm = AlarmController.sharedController.alarms.last else { return }
            scheduleLocalNotification(alarm)
            
        }
        
        navigationController?.popViewControllerAnimated(true)
        
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
