//
//  AppDelegate.swift
//  tcell
//
//  Created by Duczi on 17/10/14.
//  Copyright (c) 2014 Michal Duczynski. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var audioPlayer : AVAudioPlayer?
    var timer : NSTimer?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // set notification setting
        let notificationSetting = UIUserNotificationSettings(
            forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound,
            categories: nil)
        application.registerUserNotificationSettings(notificationSetting)
        
        return true
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        let enabled = (notificationSettings.types & UIUserNotificationType.Alert) != UIUserNotificationType.allZeros
        println("Notifications enabled: \(enabled), actual: \(notificationSettings)")
    }
    
    func playSound() {
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("tritone", ofType: "mp3")!)
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil)
        audioPlayer!.numberOfLoops = -1; //loop
        audioPlayer!.play()
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        //DID RECEIVE LOCAL NOTIF
        //playSound()
        
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //Save Data
        let viewController = window!.rootViewController as ViewController
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        let data = viewController.timerModels.map({ timer in NSKeyedArchiver.archivedDataWithRootObject(timer) })
        userDefaults.setObject(data, forKey: "timers")
        userDefaults.synchronize()
        println("Saved data")
        
        //Schedule Notifications
        for timer in viewController.timerModels {
            if timer.running {
                let notif = UILocalNotification()
                notif.fireDate = timer.leftSince.dateByAddingTimeInterval(timer.secondsLeft)
                notif.alertBody = "\(timer.lengthInSeconds) are up"
                notif.soundName = UILocalNotificationDefaultSoundName
                notif.applicationIconBadgeNumber = 1
                application.scheduleLocalNotification(notif)
            }
        }
        
        timer?.invalidate()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        println("Application active")
        let application = UIApplication.sharedApplication()
        let scheduled = application.scheduledLocalNotifications as [UILocalNotification]
        println("Scheduled notifications \(scheduled)")
        application.cancelAllLocalNotifications()
        
        // Set timer
        let viewController = window!.rootViewController as ViewController
        let sel = Selector.convertFromStringLiteral("onTick")
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: viewController, selector: sel, userInfo: nil, repeats: true)

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

