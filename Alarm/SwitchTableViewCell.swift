//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Jeff Norton on 7/5/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
    
}

class SwitchTableViewCell: UITableViewCell {
    
    // MARK: - Stored Properties
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        
        if let delegate = delegate {
            
            delegate.switchCellSwitchValueChanged(self)
        }
        
    }
    
    // MARK: - Methods
    
    func updateWithAlarm(alarm: Alarm) {
        
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.on = alarm.enabled
        
    }
    

}
