//
//  AppDelegate.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/10.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit
import AVFoundation

let JPushKey = "3060da25a2635f881d5fe505"
let JPushSecret = "64bb3fc6f61f5adff5be82e6"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationTracker: LocationTracker!
    var locationUpdateTimer: NSTimer!
    var audioPlayer:AVAudioPlayer?
    
    func setUpLocationTraker()
    {
        locationUpdateTimer?.invalidate()
        locationUpdateTimer = nil
        locationTracker?.stopLocationTracking()
        locationTracker = nil
        
        if DataCache.Share.User.id != ""
        {
            locationTracker = LocationTracker()
            locationTracker.startLocationTracking()
            
            locationUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(120, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
        }
        
    }
    
    func updateLocation()
    {
        locationTracker?.updateLocationToServer {[weak self] (latitude, longitude) -> Void in
            
            print("定位坐标为: \(latitude),\(longitude)")
            
            //let dict = BMKConvertBaiduCoorFrom(CLLocationCoordinate2D(latitude: latitude, longitude: longitude),BMK_COORDTYPE_GPS)
            
            //let baiduCoor = BMKCoorDictionaryDecode(dict);//转换后的百度坐标
            
            //转换后的高德坐标
            let baiduCoor = AMapCoordinateConvert(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), AMapCoordinateType.GPS)
            
            print("转换后的坐标为: \(baiduCoor)")
            
            let url = "http://api.0539cn.com/index.php?c=User&a=postPosition&mob=\(UMob)&identify=\(UIdentify)&lat=\(baiduCoor.latitude)&lng=\(baiduCoor.longitude)"
            
            XHttpPool.requestJson(url, body: nil, method: .GET, block: {[weak self] (res) in
                
                print(res)
            })
            
        }
    }
    
    func playSound()
    {
        if !DataCache.Share.appConfig.sound {return}
        audioPlayer?.stop()
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
        application.setStatusBarStyle(.LightContent, animated: true)
        application.statusBarStyle = .LightContent
        
        XHttpPool.Debug = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setUpLocationTraker), name: NoticeWord.UserChanged.rawValue, object: nil)

        if(CLLocationManager.authorizationStatus() == .Denied || CLLocationManager.authorizationStatus() == .Restricted)
        {
            let alert = UIAlertView(title: nil, message:"APP未开启定位,请在设置中开启", delegate:self, cancelButtonTitle: "确定")
            alert.show()
        }
        else
        {
            if UIApplication.sharedApplication().backgroundRefreshStatus == .Denied
            {
                
                let alert = UIAlertView(title: nil, message:"APP未开启后台应用刷新,请点击设置->通用->后台应用刷新进行设置", delegate:self, cancelButtonTitle: "确定")
                alert.show()
            }
            else if UIApplication.sharedApplication().backgroundRefreshStatus == .Restricted
            {
                
                let alert = UIAlertView(title: nil, message:"APP未开启后台应用刷新,请点击设置->通用->后台应用刷新进行设置", delegate:self, cancelButtonTitle: "确定")
                alert.show()
            }
//            else
//            {
//                setUpLocationTraker()
//            }
        }
        
        
 
        XOC.initJPush()
        JPUSHService.setupWithOption(launchOptions, appKey: JPushKey, channel: "", apsForProduction: false)
        JPUSHService.setDebugMode()
        
     
        let url = NSURL(fileURLWithPath: "sound.caf".path)
        
        do
        {
            audioPlayer = try? AVAudioPlayer(contentsOfURL: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 1.0
        }
        catch
        {
            
        }
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        print("极光推送注册失败 error: \(error)")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        JPUSHService.handleRemoteNotification(userInfo)
        playSound()
        print("收到推送 000")
        NoticeWord.MsgChange.rawValue.postNotice()

    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        JPUSHService.handleRemoteNotification(userInfo)
        NoticeWord.MsgChange.rawValue.postNotice()
        print("收到推送 111")
        playSound()
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        NoticeWord.MsgChange.rawValue.postNotice()
        print("回到前台 !!!!!!")
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
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

