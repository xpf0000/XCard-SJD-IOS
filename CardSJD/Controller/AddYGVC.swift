//
//  AddYGVC.swift
//  CardSJD
//
//  Created by X on 16/9/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class AddYGVC: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet var name: UITextField!
    
    @IBOutlet var orderNum: UITextField!
    
    @IBOutlet var tel: UITextField!
    
    @IBOutlet var type: UILabel!
    
    var addUid = ""
    
    var gwModel:GangweiModel!
    {
        didSet
        {
            self.type.text = gwModel?.name
        }
    }
    
    @IBAction func doADD(sender: UIButton) {
        
        if !tel.checkNull() || !orderNum.checkNull()
        {
            return
        }
        
        if !tel.checkPhone(){return}
        
        if name.text?.trim() == ""
        {
            ShowMessage("该手机号码尚未注册为怀府网会员,请先注册为会员")
            return
        }
        
        if gwModel == nil
        {
            ShowMessage("请选择岗位")
            return
        }
        
        sender.enabled = false
        XWaitingView.show()
        
        let url=APPURL+"Public/Found/?service=Power.addShopWorker"
        let body="uid="+addUid+"&shopid="+SID+"&jobid="+gwModel.id+"&wnumber="+orderNum.text!.trim()
        
        XHttpPool.requestJson( url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                NoticeWord.ADDYGSuccess.rawValue.postNotice()
                XAlertView.show("员工添加成功", block: { [weak self]() in
                    if self == nil {return}
                    
                    self?.pop()
                    
                })
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "员工添加失败" : msg
                
                XAlertView.show(msg!, block: nil)
            }
            
            sender.enabled = true
            
        }

    }
    
    func checkMember(str:String)
    {
        let url=APPURL+"Public/Found/?service=Shopd.getUserInfoM"
        let body="mobile="+str+"&shopid="+SID
        
        XHttpPool.requestJson( url, body: body, method: .POST) {[weak self] (o) -> Void in
            
            if(o?["data"]["code"].int == 0)
            {
                if let name = o?["data"]["info"][0]["truename"].string
                {
                    self?.name.text = name
                    self?.addUid = o!["data"]["info"][0]["uid"].stringValue
                }
            
            }
            
        }
    }
    
    override func pop() {
        tel.removeTextChangeBlock()
        super.pop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        name.enabled = false
        
        tel.addEndButton()
        tel.keyboardType = .PhonePad
    
        tel.onTextChange { [weak self](str) in
            
            if str.length() ==  11
            {
                self?.checkMember(str)
            }
            
        }
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=view1
        tableView.tableHeaderView=view1
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 0 || indexPath.row == 4)
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
        else if(indexPath.row > 4 )
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
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                tableView.layoutMargins=UIEdgeInsetsZero
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
            
        case 4:
            ""
            let vc = GWListVC()
            vc.title = "选择岗位"
            vc.getGW({[weak self] (model) in
                
                if let m = model as? GangweiModel
                {
                    self?.gwModel = m
                }
                
                
            })
            
            self.navigationController?.pushViewController(vc, animated: true)

        default:
            ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.endEdit()
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
