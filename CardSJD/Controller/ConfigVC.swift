//
//  AppConfigVC.swift
//  lejia
//
//  Created by X on 15/10/10.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

class ConfigVC: UITableViewController ,UIAlertViewDelegate{
    
    @IBOutlet var logoutButton: UIButton!
    
    @IBOutlet var cacheNum: UILabel!
    
    let logoutAlert = UIAlertView()
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var allowPutNoticy: UISwitch!
    
    @IBAction func logout(sender: AnyObject) {
        
        logoutAlert.delegate = self
        logoutAlert.title = "注销登录"
        logoutAlert.message = "确定要登出账户吗?"
        logoutAlert.addButtonWithTitle("取消")
        logoutAlert.addButtonWithTitle("确定")
        logoutAlert.show()
        
    }
    
    func noticeState(s:UISwitch)
    {
        DataCache.Share.appConfig.notic = s.on
        
        if(!s.on)
        {
            UIApplication.sharedApplication().unregisterForRemoteNotifications()
        }
        else
        {
            RegistPushNotice()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackButton()
        
//        logoutButton.hidden = (DataCache.Share.userModel.uid != "") ? false : true

        allowPutNoticy.setOn(DataCache.Share.appConfig.notic, animated: false)
        
        allowPutNoticy.addTarget(self, action: #selector(noticeState(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        table.tableFooterView=view1
        table.tableHeaderView=view1
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if(indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3)
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else if(indexPath.row > 6 )
        {
            cell.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, 15, 0, 15)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
   
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.table.separatorInset=UIEdgeInsetsZero
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                self.table.layoutMargins=UIEdgeInsetsZero
            } else {
                // Fallback on earlier versions
            }
        }
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 1)
        {
            let alertView = UIAlertView()
            alertView.delegate = self
            alertView.title = "清除缓存"
            alertView.message = "确定要清除缓存?"
            alertView.addButtonWithTitle("取消")
            alertView.addButtonWithTitle("确定")
            alertView.show()
        }
        
        if(indexPath.row == 3)
        {
            let vc:UserFeedVC = "UserFeedVC".VC("Main") as! UserFeedVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if(indexPath.row == 4)
        {
            let vc:AboutVC = "AboutVC".VC("Main") as! AboutVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if(alertView ==  logoutAlert && buttonIndex == 1)
        {
            
            //DataCache.Share.userModel.reSet()
            logoutButton.hidden = true
            NoticeWord.LogoutSuccess.rawValue.postNotice()

            return
            
        }
        
        if(buttonIndex == 1)
        {
            XImageUtil.removeAllFile()
            self.cacheNum.text = "0.00M"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cacheNum.text = String(format: "%.2fM", XImageUtil.ImageCachesSize()/1024.0/1024.0)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
