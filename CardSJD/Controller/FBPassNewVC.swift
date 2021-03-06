//
//  FBPassNewVC.swift
//  chengshi
//
//  Created by X on 15/11/29.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

class FBPassNewVC: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var verCode: UITextField!
    
    @IBOutlet var cellContent: UIView!
    
    var tel = ""
    var code = ""

    weak var rootVC:LoginVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.phone.addEndButton()
        self.verCode.addEndButton()
        
        phone.secureTextEntry = true
        verCode.secureTextEntry = true
        
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

        if !self.phone.checkNull() || !self.verCode.checkNull()
        {
            return
        }

        let p=self.verCode.text!.trim()
        let p1=self.phone.text!.trim()
        
        self.view.endEdit()
        
        if p != p1
        {
            ShowMessage("新密码和确认密码不一致")
            return
        }
        
        sender.enabled = false
        XWaitingView.show()
        
        let url=APPURL+"Public/Found/?service=User.updatePass"
        let body="mobile="+tel+"&code="+code+"&password="+p
        
        XHttpPool.requestJson(url, body: body, method: .POST) { (o) -> Void in
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                XAlertView.show("密码重置成功", block: { [weak self]() in
                    
                    
                    var vc:UIViewController?
                    if let arr = self?.navigationController?.viewControllers
                    {
                        for item in arr
                        {
                            if item is LoginVC
                            {
                                vc = item
                            }
                        }
                    }
                    
                    if vc != nil
                    {
                        self?.navigationController?.popToViewController(vc!, animated: true)
                    }
                    else
                    {
                        self?.pop()
                    }
                    
                    })
                
                DataCache.Share.User.password = p
                DataCache.Share.User.save()
                
                
                return
                
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "密码重置失败" : msg
                sender.enabled = true
                
                XAlertView.show(msg!, block: nil)
                
            }
            
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.phone.text = ""
        self.phone.enabled = true
        self.verCode.text = ""
    }
    
    
    deinit
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
