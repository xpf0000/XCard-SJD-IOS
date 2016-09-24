//
//  AppDelegate.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/10.
//  Copyright © 2016年 QS. All rights reserved.
//  http://182.92.70.85/hfshopapi/Public/Found/all.php

import UIKit
import AVFoundation

let JPushKey = "3060da25a2635f881d5fe505"
let JPushSecret = "64bb3fc6f61f5adff5be82e6"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
        application.setStatusBarStyle(.LightContent, animated: true)
        application.statusBarStyle = .LightContent
        
        XHttpPool.Debug = true
        
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    deinit
    {
    
    }

}

