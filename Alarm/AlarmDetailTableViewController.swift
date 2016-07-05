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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    // MARK: - UITableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let alarm = alarm {
            updateWithAlarm(alarm)
            setupView()
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

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
                enableButton.titleLabel?.text = "Enable"
                enableButton.backgroundColor = .greenColor()
            case false:
                enableButton.titleLabel?.text = "Disable"
                enableButton.backgroundColor = .redColor()
            }
        } else {
            enableButton.hidden = true
        }
    }
    
    func updateWithAlarm(alarm: Alarm) {
        
        guard let alarmDate = alarm.fireDate else {
            return
        }
        
        datePicker.date = alarmDate
        nameLabel.text = alarm.name
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func enableButtonTapped(sender: UIButton) {
    }
    
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
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
