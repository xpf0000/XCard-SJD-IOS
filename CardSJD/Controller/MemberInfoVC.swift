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
    
    @IBOutlet var table: XTableView!
    
    var hArr:[CGFloat] = [100,12,50,0]

    var model:MemberModel = MemberModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title="会员详情"
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        name.text = model.truename
        tel.text = model.mobile
        
        table.hideFootRefresh()
        table.hideHeadRefresh()
        table.cellHeight = 80.0
        
        table.httpHandle.BeforeBlock {[weak self] (arr) in
            
            self?.hArr[3] = 80.0 * CGFloat(arr.count)
            
            self?.tableView.reloadData()
            
        }
        
        let url = APPURL+"Public/Found/?service=Hyk.getShopCardY&shopid="+SID+"&uid="+model.uid
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: CardTypeModel.self, CellIdentifier: "CardTypeCell")
        table.show()

        
//        
//        let names = ["充值卡","积分卡","计次卡","打折卡"]
//        
//        table.setHandle("", pageStr: "", keys: ["data"], model: CardTypeModel.self, CellIdentifier: "CardTypeCell")
//        table.hideFootRefresh()
//        table.hideHeadRefresh()
//        table.cellHeight = 80.0
////        for(index,name) in names.enumerate()
////        {
////            let m = CardTypeModel()
////            m.name = name
////            m.img = "card_type\(index).png"
////            m.info = "卡说明"
////            table.httpHandle.listArr.append(m)
////        }
//        table.Delegate(self)
//        
//        table.reloadData()
//        
//        hArr[5] = 80.0 * CGFloat(names.count)
//        
//        tableView.reloadData()

        
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
