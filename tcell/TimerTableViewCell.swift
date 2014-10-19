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
    
    weak var timerModel: UserTimerModel?
    
    @IBOutlet weak var timerDisplay: UILabel!
    
    @IBOutlet weak var changeStateBtn: UIButton!
    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBAction func addOneHour(sender: AnyObject) {
        addToTime(60*60)
    }
    @IBAction func addTenMinutes(sender: UIButton) {
        addToTime(10*60)
    }
    @IBAction func addOneMinute(sender: AnyObject) {
        addToTime(60)
    }
    @IBAction func addTenSeconds(sender: AnyObject) {
        addToTime(10)
    }

    func addToTime(seconds:Double) {
        timerModel!.lengthInSeconds += seconds
        timerModel!.secondsLeft += seconds
        updateChangeStateBtn()
        updateAndShallRing()
    }
    
    @IBAction func changeState(sender: UIButton) {
        let running = !timerModel!.running
        timerModel!.running = running
        updateChangeStateBtn()
        //sender.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
        if running {
            timerModel!.leftSince = NSDate()
        } else {
            //update how much time is left
            let timeDiff = NSDate().timeIntervalSinceDate(timerModel!.leftSince)
            timerModel!.secondsLeft -= timeDiff
            timerModel!.elapsed += timeDiff
        }
    }
    
    func setup(timerModel: UserTimerModel) {
        //TODO: move to init
        self.timerModel = timerModel
        updateAndShallRing()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        updateChangeStateBtn()
    }
    
    func updateAndShallRing() -> Bool {
        if timerModel!.running {
            let time = NSDate()
            let secondsElapsed = time.timeIntervalSinceDate(timerModel!.leftSince)
            let secondsNowLeft = timerModel!.secondsLeft - secondsElapsed
            
            timerDisplay.text = secondsToString(secondsNowLeft)
            progress.progress =  Float((timerModel!.elapsed + secondsElapsed) / timerModel!.lengthInSeconds)
            if secondsNowLeft <= 1 {
                timerModel!.running = false
                timerModel!.secondsLeft = 0
                timerModel!.leftSince = time
                updateChangeStateBtn()
                return true
            } else {
                return false
            }
        } else {
            timerDisplay.text = secondsToString(timerModel!.secondsLeft)
            progress.progress =  timerModel!.lengthInSeconds > 0 ? Float(timerModel!.elapsed / timerModel!.lengthInSeconds) : 0
            return false
        }
    }
    
    func secondsToString(seconds: Double) -> String {
        let hours = floor(seconds / 3600)
        let minutes = floor((seconds / 60) - hours * 60)
        let sec = seconds - 3600 * hours - 60 * minutes
        if hours > 0 {
            return "\(Int(hours)) h \(Int(minutes))"
        } else {
            return "\(Int(minutes)) m \(Int(sec))"
        }
    }
    
    func updateChangeStateBtn() {
        let canRun = (timerModel!.secondsLeft > 0)
        changeStateBtn.enabled = canRun
        
        let image = timerModel!.running ? "pause" : "run"
        changeStateBtn.setTitle(image, forState: UIControlState.Normal)
        
    }
    
}