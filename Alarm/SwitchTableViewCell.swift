//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Jeff Norton on 7/5/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    // MARK: - Stored Properties
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    @IBAction func switchValueChanged(sender: UISwitch) {
    }
    

}
