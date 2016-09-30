//
//  TopUpManageVC.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class TopUpManageVC: UITableViewController {
    
    @IBOutlet var total: UILabel!
    
    @IBOutlet var tmsg: UILabel!
    
    @IBOutlet var num1: UILabel!
    
    @IBOutlet var num2: UILabel!
    
    @IBOutlet var num3: UILabel!
    
    var hArr:[CGFloat] = [170, 12,55,55,55,55]
    
    var model:ValueSumModel = ValueSumModel()
    {
        didSet
        {
            total.text = model.day
            tmsg.text = "今日充值次数: "+model.daycnum+"次"
            num1.text = "￥"+model.week
            num2.text = "￥"+model.month
            num3.text = "￥"+model.year
            
        }
    }
    
    func http()
    {
        let url = APPURL+"Public/Found/?service=Shopt.getValueSum&shopid="+SID

        XHttpPool.requestJson(url, body: nil, method: .POST) { [weak self](o) -> Void in
            
            if let info = o?["data"]["info"]
            {
                self?.model = ValueSumModel.parse(json: info, replace: nil)
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "统计数据获取失败" : msg
                
                XAlertView.show(msg!, block: nil)
            }
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title="充值管理"
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
 
        self.http()
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 2
        {
            let vc = "TopupDetailVC".VC("Main") as! TopupDetailVC
            
            vc.model = self.model
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return hArr[indexPath.row]
    }
    
    let sarr = [0,1,5,6,7]
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(!sarr.contains(indexPath.row))
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15)
            if #available(iOS 8.0, *) {
                cell.layoutMargins=UIEdgeInsetsMake(0, 15, 0, 15)
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
        
        tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if #available(iOS 8.0, *) {
            tableView.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
