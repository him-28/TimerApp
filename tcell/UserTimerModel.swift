//
//  UserTimerModel.swift
//  tcell
//
//  Created by Duczi on 18/10/14.
//  Copyright (c) 2014 Michal Duczynski. All rights reserved.
//

import Foundation

class UserTimerModel : NSObject, NSCoding {
    var expanded: Bool = false
    var leftSince: NSDate
    var lengthInSeconds: Double = 0
    var secondsLeft: Double = 0
    var running: Bool = false
    
    init(leftSince: NSDate) {
        self.leftSince = leftSince
    }
    
    required init(coder aDecoder: NSCoder) {
        // I can't use self here, so no reflection
        self.expanded = (aDecoder.decodeObjectForKey("expanded") as Bool)
        self.leftSince = (aDecoder.decodeObjectForKey("leftSince") as NSDate)
        self.lengthInSeconds = (aDecoder.decodeObjectForKey("lengthInSeconds") as Double)
        self.secondsLeft = (aDecoder.decodeObjectForKey("secondsLeft") as Double)
        self.running = (aDecoder.decodeObjectForKey("running") as Bool)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        let fields = ["expanded", "leftSince", "lengthInSeconds", "secondsLeft", "running"]
        for field in fields {
            aCoder.encodeObject(self.valueForKey(field), forKey: field)
        }
    }
}