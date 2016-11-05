//
//  CardConsumeDoVC.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CardConsumeDoVC: UITableViewController {
    
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
        
        if !cznum.checkNull()
        {
            return
        }
        
        XWaitingView.show()
        sender.enabled = false
        
        let url=APPURL+"Public/Found/?service=Hyk.addCost"
        let body="uid="+userModel!.uid+"&username="+userModel!.username+"&mcardid="+typeModel!.mcardid+"&value="+cznum.text!.trim()+"&bak="+mark.text!.trim()
        
        XHttpPool.requestJson( url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            print(o)
            
            if(o?["data"]["code"].int == 0)
            {
                NoticeWord.CardConsumSuccess.rawValue.postNotice()
                XAlertView.show("消费成功", block: { [weak self]() in
                    
                    self?.pop()
                    
                    })
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                
                print(o)
                print(o?["data"])
                
                msg = msg == "" ? "消费失败" : msg
                sender.enabled = true
                
                XAlertView.show(msg!, block: nil)
                
            }
            
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title="消费"

        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        cznum.keyboardType = .DecimalPad
        
        cznum.addEndButton()
        
        mark.autoReturn()
        
        name.text = userModel?.truename
        tel.text = userModel?.mobile
        img.backgroundColor = typeModel?.color.color
        type.text = typeModel?.type
        
        cznum.onTextChange {[weak self] (str) in
            
            if self?.typeModel?.type == "打折卡"
            {
                if let v = self?.typeModel?.values
                {
                    let r = str.numberValue.doubleValue * v.numberValue.doubleValue
                    
                    self?.realnum.text = String.init(format: "%.2f", r)
                }
                
            }
            else
            {
                self?.realnum.text = str
            }
            
        }
        
        if typeModel?.type == "计次卡"
        {
            yunum.text = typeModel!.values+"次"
            numTitle1.text = "消费次数"
            numTitle2.text = "实扣次数"
        }
        else if typeModel?.type == "打折卡"
        {
            yutitle.text = "折扣:"
            yunum.text = typeModel?.values
            numTitle1.text = "消费金额"
            numTitle2.text = "实扣金额"
        }
        else
        {
            if let v = typeModel?.values
            {
                yunum.text = "￥"+v
                numTitle1.text = "消费金额"
                numTitle2.text = "实扣金额"
            }
            
        }
        
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 1 || indexPath.row == 4)
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
        else if(indexPath.row > 5)
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
