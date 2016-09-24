//
//  UpdatePWVC.swift
//  chengshi
//
//  Created by X on 15/11/29.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

class UpdatePWVC: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var old: UITextField!
    
    @IBOutlet var new: UITextField!
    
    @IBOutlet var new1: UITextField!
    
    
    weak var rootVC:LoginVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.old.addEndButton()
        self.new.addEndButton()
        self.new1.addEndButton()
        
        old.secureTextEntry = true
        new.secureTextEntry = true
        new1.secureTextEntry = true
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        table.tableFooterView=view1
        table.tableHeaderView=view1
        
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 1 || indexPath.row == 2)
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
    
    
    @IBAction func next(sender: UIButton) {
 
        if !old.checkNull() || !new.checkNull() || !new1.checkNull()
        {
            return
        }
        
        let o=self.old.text!.trim()
        let n=self.new.text!.trim()
        let n1=self.new1.text!.trim()
        
        if n != n1
        {
            ShowMessage("新密码和确认新密码不一致")
            return
        }
        
        XWaitingView.show()
        sender.enabled = false
        
        let url=APPURL+"Public/Found/?service=User.updatePass2"
        let body="mobile="+UMob+"&oldpass="+o+"&newpass="+n
        
        XHttpPool.requestJson( url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                XAlertView.show("修改密码成功", block: { [weak self]() in
                    
                    self?.pop()
                    
                })
                
                DataCache.Share.User.password = n
                DataCache.Share.User.save()
                
 
                return
                
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "密码修改失败" : msg
                sender.enabled = true
                
                XAlertView.show(msg!, block: nil)

            }
            
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    deinit
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
