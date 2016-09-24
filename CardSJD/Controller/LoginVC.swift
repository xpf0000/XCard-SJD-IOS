//
//  LoginVC.swift
//  chengshi
//
//  Created by X on 15/11/28.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

class LoginVC: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var user: UITextField!
    
    @IBOutlet var pass: UITextField!
    
    @IBOutlet var loginIcon: UIActivityIndicatorView!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func login(sender: AnyObject) {
        
        if(!user.checkNull() || !pass.checkNull())
        {
            return
        }
        
        self.view.endEditing(true)
        
        self.loginButton.enabled = false
        self.loginIcon.startAnimating()
        UIView.animateWithDuration(0.25) { () -> Void in
            
            self.loginButton.titleLabel?.alpha = 0.0
            self.loginIcon.alpha = 1.0
            
        }
        
        let url=APPURL+"Public/Found/?service=User.login"
        let p = pass.text!.trim()
        let u = user.text!.trim()
        let body="password="+p+"&mobile="+u
        
        XHttpPool.requestJson(url, body: body, method: .POST) { [weak self](o) -> Void in
            
            if(o?["data"].dictionaryValue.count > 0)
            {
                if(o!["data"]["code"].intValue == 0 && o?["data"]["info"].arrayValue.count > 0)
                {
                    
                    DataCache.Share.User = UserModel.parse(json: o!["data"]["info"][0], replace: nil)
                    DataCache.Share.User.password = p
                    DataCache.Share.User.save()
                    
                    self?.pop()
                    
                    return
                }
                else
                {
                    self?.navigationController?.view.showAlert(o!["data"]["msg"].stringValue, block: nil)
                    
                    self?.reSetButton()
                    return
                }
            }
            else
            {
                self?.reSetButton()
                self?.navigationController?.view.showAlert("登录失败", block: nil)
            }
            
        }
        
        
        
    }
    
    func reSetButton()
    {
        self.loginButton.titleLabel?.alpha = 1.0
        self.loginIcon.alpha = 0.0
        self.loginIcon.stopAnimating()
        self.loginButton.enabled = true
    }
    
    
    @IBAction func forget(sender: AnyObject) {
        
        let vc = "FBPassVerifyVC".VC("Main")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackButton()
        
        self.user.addEndButton()
        self.pass.addEndButton()
        
        user.keyboardType = .PhonePad
        
        self.user.delegate = self
        self.pass.delegate = self
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        table.tableFooterView=view1
        table.tableHeaderView=view1
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField == self.user)
        {
            self.pass.becomeFirstResponder()
        }
        else
        {
            self.login(self.loginButton)
        }
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.user.becomeFirstResponder()
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
        //print("LoginVC deinit !!!!!!!!!!")
    }
    
}
