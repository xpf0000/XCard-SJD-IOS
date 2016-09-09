//
//  LoginVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class LoginVC: UITableViewController {

    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func doLogin(sender: AnyObject) {
        
        if !mobile.checkNull() || !password.checkNull(){return}
        
        self.view.showWaiting()
        
        let mob = mobile.text!.trim()
        let pass = password.text!.trim()
        
        let url = "http://api.0539cn.com/index.php?c=User&a=login&mob=\(mob)&pass=\(pass)&type=1"
        
        XHttpPool.requestJson(url, body: nil, method: .GET) {[weak self] (res) in
            
            RemoveWaiting()
            
            if res?["code"].int == 200
            {
                let model = UserModel.parse(json: res!["datas"], replace: nil)
                
                DataCache.Share.User = model
                
                DataCache.Share.User.save()
                
                self?.pop()
                
                return
            }
            
            if let msg = res?["message"].string
            {
                ShowMessage(msg)
            }
            else
            {
                ShowMessage("登录失败,请重试")
            }
            
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        mobile.addEndButton()
        password.addEndButton()
        
    
    }
    
    
    let rarr = [1]
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if rarr.contains(indexPath.row)
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
        else
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
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.table.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                self.table.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
