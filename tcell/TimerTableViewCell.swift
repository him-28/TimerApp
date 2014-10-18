//
//  TimerTableViewCell.swift
//  tcell
//
//  Created by Duczi on 17/10/14.
//  Copyright (c) 2014 Michal Duczynski. All rights reserved.
//


import UIKit

class TimerTableViewCell: UITableViewCell {
    
    //Properties
    
    var expanded:Bool = false
    
    @IBOutlet weak var timerDisplay: UILabel!
    
    @IBAction func addTenMinutes(sender: UIButton) {
        timerDisplay.text = timerDisplay.text! + "1"
    }
    
    @IBAction func resume(sender: UIButton) {
    }
    
    func setup() {
        //TODO: move to init
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    
}