//
//  UserFeedVC.swift
//  chengshi
//
//  Created by X on 15/12/17.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

class UserFeedVC: UITableViewController {
    
    @IBOutlet weak var textView: XTextView!
    
    override func pop() {
        self.view.endEditing(true)
        super.pop()
    }
    
   @IBAction func send(sender:UIButton)
    {
        if(!self.checkIsLogin() || !self.textView.checkNull())
        {
            return
        }
        
        if(!self.textView.checkLength(10, max: 1000))
        {
            UIApplication.sharedApplication().keyWindow?.showAlert("内容长度为10-1000个字符", block: nil)
            
            return
        }
        
        sender.enabled = false
        
        let url=APPURL+"Public/Found/?service=User.feedAdd&user="
        
        XHttpPool.requestJson(url, body: nil, method: .POST) { (o) -> Void in
            
            if(o?["data"]["code"].intValue == 0)
            {
                UIApplication.sharedApplication().keyWindow?.showAlert("发送成功", block: { (o) -> Void in
                    
                    self.pop()
                })
                
                return
            }
            
            sender.enabled = true
            UIApplication.sharedApplication().keyWindow?.showAlert("发送失败,请重试", block: nil)
            
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addBackButton()
        self.title = "意见反馈"
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=view1
        tableView.tableHeaderView=view1

        textView.placeHolder("有什么意见或好的想法, 请告诉我们!")
        textView.inputAccessoryView = nil
        textView.becomeFirstResponder()
        
        textView.addEndButton()
        
        
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row < 2)
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
        
        tableView.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                tableView.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
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
