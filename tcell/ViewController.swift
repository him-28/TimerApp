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
    
    var timerModels = [UserTimerModel]()

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        println("set row height")
        //FIXME: It causes looping!
        //var cell = (tableView.cellForRowAtIndexPath(indexPath)! as TimerTableViewCell)
        return CGFloat.convertFromIntegerLiteral(timerModels[indexPath.row].expanded ? 100 : 100)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("set cell content")
        let cell = (tableView.dequeueReusableCellWithIdentifier("timerCell")! as TimerTableViewCell)
        cell.timerDisplay.text = "text \(indexPath.row)"
        cell.setup(timerModels[indexPath.row])
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected \(indexPath.row)")
        let cell = (tableView.cellForRowAtIndexPath(indexPath)! as TimerTableViewCell)
        timerModels[indexPath.row].expanded = !timerModels[indexPath.row].expanded
        println(timerModels[indexPath.row].expanded)
    }
    
    //=================================================
    
    func onTick() {
        for (i, timer) in enumerate(timerModels) {
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            let cell = (tableView.cellForRowAtIndexPath(indexPath)! as TimerTableViewCell)
            if cell.updateAndShallRing() {
                //ring
            }
        }
        println("tick")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("view did load")
        timerModels.append(UserTimerModel(leftSince: NSDate()))
        
        // Restore session
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let outAny: AnyObject = userDefaults.objectForKey("timers") {
            //load a stored session
            let outData = outAny as [NSData]
            timerModels = outData.map({ data in (NSKeyedUnarchiver.unarchiveObjectWithData(data) as UserTimerModel) })
            println("Read \(timerModels[0].secondsLeft)")
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

