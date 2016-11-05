//
//  CardTopupDoVC.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CardTopupDoVC: UITableViewController {

    @IBOutlet var img: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var tel: UILabel!
    
    @IBOutlet var type: UILabel!
    
    @IBOutlet var yutitle: UILabel!
    
    @IBOutlet var yunum: UILabel!
    
    @IBOutlet var cznum: UITextField!
    
    @IBOutlet var realnum: UITextField!
    
    @IBOutlet var numTitle1: UILabel!
    
    @IBOutlet var numTitle2: UILabel!
    
    @IBOutlet var line: UIView!
    
    @IBOutlet var linew: NSLayoutConstraint!
    
    @IBOutlet var mark: UITextField!
    
    var userModel:MemberModel?
    var typeModel:CardTypeModel?
    
    @IBAction func submit(sender: UIButton) {
        
        if !cznum.checkNull() || !realnum.checkNull()
        {
            return
        }
        
        XWaitingView.show()
        sender.enabled = false
        
        let url=APPURL+"Public/Found/?service=Hyk.addValues"
        let body="uid="+userModel!.uid+"&username="+userModel!.username+"&mcardid="+typeModel!.mcardid+"&money="+realnum.text!.trim()+"&value="+cznum.text!.trim()+"&bak="+mark.text!.trim()
        
        XHttpPool.requestJson( url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                NoticeWord.CardTopupSuccess.rawValue.postNotice()
                XAlertView.show("充值成功", block: { [weak self]() in
                    
                    self?.pop()
                    
                })
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "充值失败" : msg
                sender.enabled = true
                
                XAlertView.show(msg!, block: nil)
                
            }
            
        }
        
    }
    
    override func pop() {
        mark.autoReturnClose()
        super.pop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title="充值"
        cznum.keyboardType = .DecimalPad
        realnum.keyboardType = .DecimalPad
        
        cznum.addEndButton()
        realnum.addEndButton()
        
        mark.autoReturn()
        
        
        line.backgroundColor = tableView.separatorColor
        linew.constant = 0.5
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        
        name.text = userModel?.truename
        tel.text = userModel?.mobile
        img.backgroundColor = typeModel?.color.color
        type.text = typeModel?.type
        
        if typeModel?.type == "计次卡"
        {
            numTitle1.text = "充值次数"
            yunum.text = typeModel!.values+"次"
        }
        else
        {
            if let v = typeModel?.values
            {
               yunum.text = "￥"+v
            }
            
        }
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 1 || indexPath.row == 4)
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15)
            if #available(iOS 8.0, *) {
                cell.layoutMargins=UIEdgeInsetsMake(0, 15, 0, 15)
            } else {
                // Fallback on earlier versions
            }
        }
        else if(indexPath.row > 5)
        {
            cell.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
            if #available(iOS 8.0, *) {
                cell.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
        else
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
            if #available(iOS 8.0, *) {
                cell.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
            } else {
                // Fallback on earlier versions
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
