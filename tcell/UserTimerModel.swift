//
//  UserTimerModel.swift
//  tcell
//
//  Created by Duczi on 18/10/14.
//  Copyright (c) 2014 Michal Duczynski. All rights reserved.
//

import Foundation

class UserTimerModel {
    var expanded: Bool = false
    var leftSince: NSDate
    var lengthInSeconds: Double = 0
    var secondsLeft: Double = 0
    var running: Bool = false
    
    init(leftSince: NSDate) {
        self.leftSince = leftSince
    }
}