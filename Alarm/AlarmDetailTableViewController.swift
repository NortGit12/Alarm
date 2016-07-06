//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Jeff Norton on 7/5/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
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
    
    // MARK: - Table view data source
    
    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
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
            switch alarm.enabled {
            case true: alarm.enabled = false
            case false: alarm.enabled = true
            }
            
            setupView()
        }
    }
    
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        
        guard let fireTimeInterval = datePicker?.countDownDuration, name = nameTextField?.text else { return }
        
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
            AlarmController.sharedController.updateAlarm(alarm, fireTimeFromMidnight: fireTimeInterval, name: name, isEnabled: isEnabled)
            
            
        } else {
            
            // New alarm
            AlarmController.sharedController.addAlarm(fireTimeInterval, name: name, isEnabled: isEnabled)
            
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
