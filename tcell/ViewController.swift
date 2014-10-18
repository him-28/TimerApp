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
    @IBOutlet weak var tableView: UITableView!
    var times = [UserTimerModel]()
    var expanded = false
    
    var timer = NSTimer()

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
            let seconds = floor(now.timeIntervalSinceReferenceDate - timer.leftSince.timeIntervalSinceReferenceDate)
            if seconds >= timer.secondsLeft {
                //ring
            }
            //update display
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            let cell = (tableView.cellForRowAtIndexPath(indexPath)! as TimerTableViewCell)
            cell.timerDisplay.text = "\(seconds)"
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("view did load")
        times.append(UserTimerModel(leftSince: NSDate()))
        setNotification()
        //reference app delegate
        //AppDelegate appDelegate = UIApplication.sharedApplication().delegate!
        let sel = Selector.convertFromStringLiteral("onTick")
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: sel, userInfo: nil, repeats: true)
        //timer.invalidate()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

