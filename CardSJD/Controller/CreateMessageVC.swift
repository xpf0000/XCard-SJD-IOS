//
//  CreateMessageVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CreateMessageVC: UITableViewController {

    @IBOutlet var info: XTextView!
    
    @IBOutlet var mtitle: UITextField!
    
    @IBAction func submit(sender: UIButton)
    {
        if !mtitle.checkNull() || !info.checkNull()
        {
            return
        }
        
        sender.enabled = false
        XWaitingView.show()
        
        let uname = DataCache.Share.User.username
        
        let url=APPURL+"Public/Found/?service=Shopa.addMessages"
        let body="uid="+UID+"&username="+uname+"&title="+mtitle.text!.trim()+"&content="+info.text!.trim()
        
        XHttpPool.requestJson( url, body: body, method: .POST) {[weak self] (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                NoticeWord.MsgChange.rawValue.postNotice()
                XAlertView.show("消息发送成功", block: { [weak self]() in
                    if self == nil {return}
                    
                    self?.pop()
                    
                    })
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "消息发送失败" : msg
                
                XAlertView.show(msg!, block: nil)
            }
            
            sender.enabled = true
            
        }
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布消息"
        self.addBackButton()
        mtitle.autoReturn()
        
        info.placeHolder("请输入消息内容")
        
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=view1
        tableView.tableHeaderView=view1
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 0 || indexPath.row == 2)
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
        else if(indexPath.row > 2 )
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
        
        tableView.separatorInset=UIEdgeInsetsZero
        if #available(iOS 8.0, *) {
            tableView.layoutMargins=UIEdgeInsetsZero
        } else {
            // Fallback on earlier versions
        }
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
