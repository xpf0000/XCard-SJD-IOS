//
//  MemberInfoVC.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MemberInfoVC: UITableViewController {
    
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var tel: UILabel!
    
    @IBOutlet var line: UIView!
    
    @IBOutlet var line1: UIView!
    
    @IBOutlet var line2: UIView!
    
    @IBOutlet var num: UILabel!
    
    @IBOutlet var num1: UILabel!
    
    @IBOutlet var num2: UILabel!
    
    @IBOutlet var num3: UILabel!
    
    @IBOutlet var linew: NSLayoutConstraint!
    
    @IBOutlet var table: XTableView!
    
    var hArr:[CGFloat] = [100, 12,100,12,50,0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title="会员详情"
        
        self.addNvButton(false, img: "right_more.png", title: nil) {[weak self] (btn) in
            
        }
        
        line.backgroundColor = tableView.separatorColor
        linew.constant = 0.5
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        let names = ["充值卡","积分卡","计次卡","打折卡"]
        
        table.setHandle("", pageStr: "", keys: ["data"], model: CardTypeModel.self, CellIdentifier: "CardTypeCell")
        table.hideFootRefresh()
        table.hideHeadRefresh()
        table.cellHeight = 80.0
        for(index,name) in names.enumerate()
        {
            let m = CardTypeModel()
            m.name = name
            m.img = "card_type\(index).png"
            m.info = "卡说明"
            table.httpHandle.listArr.append(m)
        }
        table.Delegate(self)
        
        table.reloadData()
        
        hArr[5] = 80.0 * CGFloat(names.count)
        
        tableView.reloadData()

        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return hArr[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == table
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
            
            return
        }
        
        if(indexPath.row == 4)
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
        
        tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                tableView.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
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
