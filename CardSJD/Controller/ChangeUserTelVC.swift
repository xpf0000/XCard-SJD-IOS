//
//  ChangeUserTelVC.swift
//  chengshi
//
//  Created by X on 15/11/29.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

class ChangeUserTelVC: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var newPhone: UITextField!
    
    @IBOutlet var verCode: UITextField!
    
    @IBOutlet var verfyBtn: XVerifyButton!
    
    weak var rootVC:LoginVC?
    
    override func pop() {
        
        newPhone.removeTextChangeBlock()
        super.pop()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.phone.addEndButton()
        newPhone.addEndButton()
        
        verfyBtn.needHas = false
        
        phone.keyboardType = .PhonePad
        newPhone.keyboardType = .PhonePad
        
        newPhone.onTextChange { [weak self](str) in
            
            self?.verfyBtn.phone = str
        }
        
        
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=view1
        tableView.tableHeaderView=view1
        
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 0 || indexPath.row == 3)
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
        else if(indexPath.row > 3)
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
        
        tableView.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
        if #available(iOS 8.0, *) {
            tableView.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    @IBAction func next(sender: UIButton) {
        
        if !newPhone.checkNull() || !phone.checkNull() || !verCode.checkNull()
        {
            return
        }
        
        let code=self.verCode.text!.trim()
        let tel=self.phone.text!.trim()
        let newTel = newPhone.text!.trim()
        
        if tel != UMob
        {
            ShowMessage("原手机号码有误")
            return
        }
        
        if tel == newTel
        {
            ShowMessage("新手机号码不能和原手机号码一样")
            return
        }
        
        sender.enabled = false
        XWaitingView.show()
        
        let url=APPURL+"Public/Found/?service=User.updateMobile"
        let body="mobile="+tel+"&newmobile="+newTel+"&code="+code
        
        XHttpPool.requestJson(url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                ShowMessage("手机号码修改成功")
                DataCache.Share.User.mobile = newTel
                DataCache.Share.User.save()
                self.pop()
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "验证失败" : msg
                
                sender.enabled = true
                UIApplication.sharedApplication().keyWindow?.showAlert(msg!, block: nil)
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
