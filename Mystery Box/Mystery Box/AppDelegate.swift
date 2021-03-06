//
//  AppDelegate.swift
//  Mystery Box
//
//  Created by PATRICK PERINI on 8/24/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Setup Parse
        Parse.setApplicationId("OLjnAy2bGdU2J1AcQ118Ay5MV20ekLPqCb8U299K",
            clientKey: "g7UeR6aaCGbuInTTU8jIthSnsqcoHA1MMG3GG9lq")
        
        Content.registerSubclass()
        
        // Setup Push        
        let settings = UIUserNotificationSettings(forTypes: [
            .Alert,
            .Badge,
            .Sound
        ], categories: nil)
        
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.channels = [""]
        
        installation.saveInBackgroundWithBlock { (success: Bool, err: NSError?) in
            print(success, err)
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = storyboard.instantiateInitialViewController()
        
        self.window?.rootViewController = initialVC
    }
}

