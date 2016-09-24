//
//  FBPassVerifyVC.swift
//  chengshi
//
//  Created by X on 15/11/29.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

class FBPassVerifyVC: UITableViewController,UITextFieldDelegate {

    @IBOutlet var table: UITableView!
    
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var verCode: UITextField!
    
    @IBOutlet var cellContent: UIView!
    
    @IBOutlet weak var verifyBtn: XVerifyButton!
    
    
    weak var rootVC:LoginVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.phone.addEndButton()

        verifyBtn.needHas = true
        
        
        verifyBtn.block={
            [weak self]
            (o)->Void in
            if(self != nil)
            {
                self?.phone.enabled = false
            }
        }
        
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        table.tableFooterView=view1
        table.tableHeaderView=view1
        
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == self.phone)
        {
            var txt=textField.text!
            txt=(txt as NSString).stringByReplacingCharactersInRange(range, withString: string)
            verifyBtn.phone = txt
        }
        
        
        
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
        
        if(!self.phone.checkNull() || !self.verCode.checkNull())
        {
            return
        }
        
        self.view.endEdit()
        
        if !self.phone.checkPhone()
        {
            return
        }
        
        sender.enabled = false
        XWaitingView.show()
        
        let code=self.verCode.text!.trim()
        let phone=self.phone.text!.trim()
        
        let url=APPURL+"Public/Found/?service=User.smsVerify"
        let body="mobile="+phone+"&code="+code
        
        XHttpPool.requestJson(url, body: body, method: .POST) { (o) -> Void in
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                let vc = "FBPassNewVC".VC("Main") as! FBPassNewVC
                vc.tel = phone
                vc.code = code
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "验证失败" : msg
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
