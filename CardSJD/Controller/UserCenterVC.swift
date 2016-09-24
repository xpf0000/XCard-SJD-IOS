//
//  UserCenterVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class UserCenterVC: UITableViewController,UIAlertViewDelegate {

    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var num: UILabel!
    
    @IBOutlet weak var sound: UISwitch!
    
    @IBAction func soundChanged(sender: UISwitch) {
        
    
    }

    @IBOutlet weak var btn: UIButton!
    
    
    @IBAction func btnClick(sender: UIButton) {
        
        if sender.selected
        {
            let logoutAlert = UIAlertView()
            logoutAlert.delegate = self
            logoutAlert.title = "注销登录"
            logoutAlert.message = "确定要登出账户吗?"
            logoutAlert.addButtonWithTitle("取消")
            logoutAlert.addButtonWithTitle("确定")
            logoutAlert.show()
        }
        else
        {
            let vc = "LoginVC".VC("Main")
            
            vc.hidesBottomBarWhenPushed = true
            
            let nv = XNavigationController(rootViewController: vc)
            
            self.presentViewController(nv, animated: true, completion: nil)
            
           // self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if(buttonIndex == 1)
        {
            DataCache.Share.User.reset()
        }

    }

    func userChanged()
    {
//        btn.selected = DataCache.Share.User.id != ""
//        num.text = DataCache.Share.User.coins
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "个人中心"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userChanged), name: NoticeWord.UserChanged.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userChanged), name: NoticeWord.UpdateMoney.rawValue, object: nil)
        
        userChanged()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        table.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.row == 0)
        {
            if !self.checkIsLogin(){return}
            
            let vc = "MyWalletVC".VC("Main")
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        DataCache.Share.User.doLogin()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

   deinit
   {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
