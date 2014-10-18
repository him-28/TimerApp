//
//  ViewController.swift
//  tcell
//
//  Created by Duczi on 17/10/14.
//  Copyright (c) 2014 Michal Duczynski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //SETUP TABLE ==================================
    var times = [Timer]()
    var expanded = false
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        println("set row height")
        //FIXME: It causes looping!
        //var cell = (tableView.cellForRowAtIndexPath(indexPath)! as TimerTableViewCell)
        return CGFloat.convertFromIntegerLiteral(times[indexPath.row].expanded ? 100 : 50)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("set cell content")
        let cell = (tableView.dequeueReusableCellWithIdentifier("timerCell")! as TimerTableViewCell)
        cell.timerDisplay.text = "text \(indexPath.row)"
        cell.setup()
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected \(indexPath.row)")
        let cell = (tableView.cellForRowAtIndexPath(indexPath)! as TimerTableViewCell)
        times[indexPath.row].expanded = !times[indexPath.row].expanded
        println(times[indexPath.row].expanded)
    }
    
    //=================================================
    
    func setNotification() {
        let notif = UILocalNotification()
        let seconds = 5.0
        let date = NSDate(timeIntervalSinceNow: seconds)

        notif.fireDate = date
        notif.alertBody = "fired at \(date)"
        notif.soundName = UILocalNotificationDefaultSoundName
        notif.applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().scheduleLocalNotification(notif)
    }
    
    func onTick() {
        let now = NSDate()
        for (i, timer) in enumerate(times) {
            let seconds = (now.timeIntervalSinceReferenceDate - timer.timeStarted.timeIntervalSinceReferenceDate)/1000
            if seconds >= timer.lengthInSeconds {
                //ring
            }
            //update display
            NSIndexPath(forRow: i, inSection: 0)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("view did load")
        times.append(Timer(expanded: false, timeStarted: NSDate(), lengthInSeconds: 0))
        setNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

struct Timer {
    var expanded: Bool = false
    var timeStarted: NSDate
    var lengthInSeconds: Double = 0
}

