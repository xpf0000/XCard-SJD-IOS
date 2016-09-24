//
//  pchHeader.swift
//  swiftTest
//
//  Created by X on 15/3/3.
//  Copyright (c) 2015年 swiftTest. All rights reserved.
//

import UIKit
import ImageIO

//开发人员 主要用于分故事板


enum NoticeWord : String{
    
    case UpDateFriendCell="UpDateFriendCell"
    case FriendPostSuccess="FriendPostSuccess"
    case LoginSuccess="LoginSuccess"
    case LogoutSuccess="LogoutSuccess"
    case UserChanged="UserChanged"
    case UpdateUserSuccess="UpdateUserSuccess"
    case OrderChanged="OrderChanged"
    case MsgChange="MsgChange"
    case UpdateMoney="UpdateMoney"
    
}

typealias AnyBlock = (Any?)->Void
typealias XNoBlock = ()->Void

let screenScale=UIScreen.mainScreen().scale
let swidth=UIScreen.mainScreen().bounds.size.width
let sheight=UIScreen.mainScreen().bounds.size.height

let IOS_Version=((UIDevice.currentDevice().systemVersion) as NSString).doubleValue

var TempPath:String
{
    let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
    
    let cache=(paths[0] as NSString).stringByAppendingPathComponent("XCache")
    
    if(!cache.fileExistsInPath())
    {
        try! NSFileManager.defaultManager().createDirectoryAtPath(cache, withIntermediateDirectories: true, attributes: nil)
    }
    
    return cache
}

let yearSecond=60*60*24*30*12
let PI:CGFloat=3.14159265358979323846
let HttpPoolCount:Int=20
let picOutTime=864000

let WhiteDefaultIMG = UIColor.whiteColor().image

let APPNVColor = "0894ec".color!
let APPBtnGrayColor = "cacaca".color!
let APPOrangeColor = "ff7e00".color!
let APPGreenColor:UIColor = "87b207".color!
let APPBGColor:UIColor = "f2f2f2".color!
let APPBlackColor = "333333".color!
let APPMiddleColor = "666666".color!
let APPGrayColor = "999999".color!

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

func ShowMessage(str:String)
{
    UIApplication.sharedApplication().keyWindow?.addSubview(XMessage.Share())
    
    XMessage.Share().showMessage(str)
}

let APPURL="http://182.92.70.85/hfshopapi/"

let BaseHtml = "<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n" +
    "<head>\r\n" +
    "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n" +
    "<meta http-equiv=\"Cache-Control\" content=\"no-cache\" />\r\n" +
    "<meta content=\"telephone=no\" name=\"format-detection\" />\r\n" +
    "<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0\">\r\n" +
    "<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n" +
    "<title>活动简介</title>\r\n" +
    "<style>\r\n" +
    "body {background-color: #ffffff}\r\n" +
    "table {border-right:1px dashed #D2D2D2;border-bottom:1px dashed #D2D2D2}\r\n" +
    "table td{border-left:1px dashed #D2D2D2;border-top:1px dashed #D2D2D2}\r\n" +
    "img {width:100%;height: auto}\r\n" +
    "</style>\r\n</head>\r\n<body>\r\n"+"[XHTMLX]"+"\r\n</body>\r\n</html>"

