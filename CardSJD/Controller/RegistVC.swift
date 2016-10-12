//
//  RegistVC.swift
//  CardSJD
//
//  Created by X on 2016/10/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class RegistVC: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet var tel: UITextField!
    
    @IBOutlet var name: UITextField!
    
    var mobil = ""
    
    @IBAction func regist(sender: UIButton) {
        
        if(!tel.checkNull() || !name.checkNull())
        {
            return
        }
        
        if(!tel.checkPhone())
        {
            return
        }
        
        self.view.endEditing(true)
        sender.enabled = false
        XWaitingView.show()
        
        let url=APPURL+"Public/Found/?service=User.register"
        let body="mobile="+tel.text!.trim()+"&truename="+name.text!.trim()

        XHttpPool.requestJson(url, body: body, method: .POST) { [weak self](o) -> Void in
            XWaitingView.hide()
            if(o?["data"]["code"].int == 0)
            {
                "RegistSuccess".postNotice()
                XAlertView.show("会员注册成功", block: { [weak self]() in
                    
                    self?.pop()
                    
                    })
                
                return
                
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "会员注册失败" : msg
                sender.enabled = true
                
                XAlertView.show(msg!, block: nil)
                
            }

            
        }
        
        
        
    }
    
    override func pop() {
        tel.autoReturnClose()
        super.pop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackButton()
        
        self.tel.autoReturn(name)

        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=view1
        tableView.tableHeaderView=view1
        
        tel.text = mobil
        
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 1)
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
        
        self.tableView.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                self.tableView.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit
    {
        tel.autoReturnClose()
        //print("LoginVC deinit !!!!!!!!!!")
    }
    
}
