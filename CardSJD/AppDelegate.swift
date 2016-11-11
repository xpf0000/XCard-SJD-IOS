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
let AliAppKey:String="23527438"
let AliAppMSecret:String="bba99dcddeb86666951fe1421cf1c750"

let XCardColor = ["e49100","446ab4","f2666b","e6bd2c","19ad83","1d1e20","c322ec"]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func handleNoticeInfo(info:[NSObject : AnyObject]?)
    {
        print(info)
    }
    
    func RegistPushNotice()
    {
        if #available(iOS 8.0, *) {
            let settings:UIUserNotificationSettings=UIUserNotificationSettings(forTypes: [.Alert,.Sound], categories: nil)
            
            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
            
            //UMessage.registerRemoteNotificationAndUserNotificationSettings(settings)
            
        } else {
            UIApplication.sharedApplication().registerForRemoteNotificationTypes([.Alert,.Sound])
            //UMessage.registerForRemoteNotificationTypes([.Alert,.Sound])
        }
        
    }

    func onMessageReceived(notification:NSNotification)
    {
        print(notification.object)
        
        if let message = notification.object as? CCPSysMessage
        {
            let title = String.init(data: message.title, encoding: NSUTF8StringEncoding)
            
            let body = String.init(data: message.body, encoding: NSUTF8StringEncoding)
            
            print("Receive message title: \(title) | content: \(body)")
            
            if let str = title
            {
                if str == "账号在其它设备已登陆"
                {
                    NSNotificationCenter.defaultCenter().postNotificationName("AccountLogout", object: nil)
                }
            }
            
            
        }

    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
        application.setStatusBarStyle(.LightContent, animated: true)
        application.statusBarStyle = .LightContent
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onMessageReceived(_:)), name: "CCPDidReceiveMessageNotification", object: nil)
        
        XHttpPool.Debug = true
        RegistPushNotice()
        initCloudPush()
        
        sleep(3)
        
        return true
    }
    
    func initCloudPush()
    {
        
        let man = ALBBMANAnalytics.getInstance()
        man.initWithAppKey(AliAppKey, secretKey: AliAppMSecret)
        
        CloudPushSDK.asyncInit(AliAppKey, appSecret: AliAppMSecret) { (res) in
            
            if (res.success) {
                
            } else {
                
            }
        }
        
        CloudPushSDK.turnOnDebug()
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

    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        CloudPushSDK.registerDevice(deviceToken) { (res) in
            
            if (res.success) {
                
            } else {
                
            }
            
        }
        
    }
    
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        CloudPushSDK.handleReceiveRemoteNotification(userInfo)
        handleNoticeInfo(userInfo)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        CloudPushSDK.handleReceiveRemoteNotification(userInfo)
        handleNoticeInfo(userInfo)
    }

    
    deinit
    {
    
    }

}

