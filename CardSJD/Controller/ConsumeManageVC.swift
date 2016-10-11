//
//  ConsumeManageVC.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

let CardType = ["计次卡":"1","充值卡":"2","打折卡":"3","积分卡":"4"]

class ConsumeManageVC: UITableViewController {
    
    @IBOutlet var total: UILabel!
    
    @IBOutlet var num1: UILabel!
    
    @IBOutlet var num2: UILabel!
    
    @IBOutlet var num3: UILabel!
    
    @IBOutlet weak var num4: UILabel!
    
    @IBOutlet weak var num5: UILabel!
    
    var hArr:[CGFloat] = [140, 12,55,55,55,55,55,55]
    
    var tmodel:ValueSumModel = ValueSumModel()
        {
        didSet
        {
            total.text = tmodel.daycnum+"次"
            num1.text = tmodel.week+"次"
            num2.text = tmodel.month+"次"
            num3.text = tmodel.all+"次"
            num4.text = tmodel.jidu+"次"
            num5.text = tmodel.year+"次"
            
        }
    }
    
    func http()
    {
        let url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopt.getCostSum&shopid="+SID+"&ctypeid=0"
        
        XHttpPool.requestJson(url, body: nil, method: .POST) { [weak self](o) -> Void in
            
            if let info = o?["data"]["info"]
            {
                self?.tmodel = ValueSumModel.parse(json: info, replace: nil)
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
        self.title="消费管理"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(http), name: "DelRecardSuccess", object: nil)
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        http()
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 2
        {
            let vc = "ConsumeDetailVC".VC("Main") as! ConsumeDetailVC
    
            vc.model = self.tmodel
            
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
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
