//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Jeff Norton on 7/5/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate {

    // MARK: - Stored Properties
    
    // MARK: - UITableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedController.alarms.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmListCell", forIndexPath: indexPath) as? SwitchTableViewCell

        let alarm = AlarmController.sharedController.alarms[indexPath.row]
        
        cell?.updateWithAlarm(alarm)
        cell?.delegate = self

        return cell ?? UITableViewCell()
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let alarm = AlarmController.sharedController.alarms[indexPath.row]
            AlarmController.sharedController.deleteAlarm(alarm)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    // MARK: - SwitchTableViewCellDelegate
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        
        // Capture the alarm
//        guard let cellIndexPath = tableView.indexPathForCell(cell), fireTimeFromMidnight = cell.timeLabel.text, name = cell.nameLabel.text else {
//            return
//        }
        
        guard let cellIndexPath = tableView.indexPathForCell(cell) else {
            return
        }
        
        let alarm = AlarmController.sharedController.alarms[cellIndexPath.row]
            
        // Toggle the alarm's enabled property
        AlarmController.sharedController.toggleEnabled(alarm)
            
        // Reload the UITableView
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths([cellIndexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // How are we getting there?
        if segue.identifier == "viewExistingAlarmSegue" {
            
            // Where are we going?
            if let alarmDetailTableViewController = segue.destinationViewController as? AlarmDetailTableViewController {
                
                // What do we need to pack?
                if let index = tableView.indexPathForSelectedRow?.row {
                    
                    let alarm = AlarmController.sharedController.alarms[index]
                    
                    
                    // Are we finished packing?
                    alarmDetailTableViewController.alarm = alarm
                    
                }
            }
        }
    }
    

}
