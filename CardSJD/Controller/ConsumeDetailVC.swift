//
//  ConsumeDetailVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ConsumeDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var startTime: UIButton!
    
    @IBOutlet var endTime: UIButton!
    
    @IBOutlet var searchBtn: UIButton!
    
    @IBOutlet var total: UILabel!
    
    
    @IBOutlet var table: XTableView!
    
    var stime:NSDate?
    var etime:NSDate?
    
    var stimeStr = ""
    var etimeStr = ""
    
    var model:ValueSumModel = ValueSumModel()
    var ctypeid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        let leftView = UIView()
        leftView.frame = CGRectMake(0, 0, 42, 42)
        let left = UIImageView()
        left.frame = CGRectMake(8, 6, 30, 30)
        left.image = "search.png".image
        leftView.addSubview(left)
        
        startTime.layer.masksToBounds = true
        startTime.layer.cornerRadius = 6.0
        startTime.layer.borderColor =  "dcdcdc".color?.CGColor
        startTime.layer.borderWidth = 0.7
        
        endTime.layer.masksToBounds = true
        endTime.layer.cornerRadius = 6.0
        endTime.layer.borderColor =  "dcdcdc".color?.CGColor
        endTime.layer.borderWidth = 0.7
        
        table.cellHeight = 50.0
        table.Delegate(self)
        table.DataSource(self)
        
        let url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopt.getCostList&shopid="+SID+"&stime="+stimeStr+"&etime="+etimeStr+"&page=[page]&perNumber=20&ctypeid="+ctypeid
        
        table.postDict = ["xf":true]
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: MoneyDetailModel.self, CellIdentifier: "TopupDetailCell")
        
        table.httpHandle.ResultBlock {[weak self] (o) in
            
            if let sum = o?["data"]["sum"].string
            {
                self?.total.text = sum+"次"
            }
            
        }
        
        table.show()
        
        
        startTime.click { [weak self](btn) in
            
            self?.chooseTime(btn)
        }
        
        endTime.click { [weak self](btn) in
            
            self?.chooseTime(btn)
        }
        
        searchBtn.click { [weak self](btn) in
            
            self?.doSearch()
        }
        
        
    }
    
    func chooseTime(sender:UIButton)
    {
        let picker = XDatePicker()
        
        if sender == startTime
        {
            picker.maxDate = etime
        }
        else
        {
            picker.minDate = stime
        }
        
        
        
        picker.getDate({[weak self] (date, str) in
            
            let s = date.timeIntervalSince1970
            
            if sender == self?.startTime
            {
                self?.stime = date
                self?.stimeStr = "\(s)"
                self?.startTime.setTitle(str, forState: .Normal)
            }
            else
            {
                self?.etime = date
                self?.etimeStr = "\(s)"
                self?.endTime.setTitle(str, forState: .Normal)
            }
            
            })
        
    }
    
    func doSearch()
    {
        let url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopt.getValueList&shopid="+SID+"&stime="+stimeStr+"&etime="+etimeStr+"&page=[page]&perNumber=20"
        table.httpHandle.url = url
        table.httpHandle.reSet()
        table.httpHandle.handle()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return  (table.httpHandle.listArr[indexPath.row] as! MoneyDetailModel).status != "-1"
        
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        return "作废"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            
            let id=(self.table.httpHandle.listArr[indexPath.row] as! MoneyDetailModel).id
            
            let url=APPURL+"Public/Found/?service=Shopt.delCost&id="+id
            
            XHttpPool.requestJson(url, body: nil, method: .GET, block: { (json) in
                
                if let status = json?["data"]["code"].int
                {
                    if status == 0
                    {
                        (self.table.httpHandle.listArr[indexPath.row] as! MoneyDetailModel).status = "-1"
                        
                        self.table.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                        
                        "DelRecardSuccess".postNotice()
                        
                    }
                    else
                    {
                        ShowMessage(json!["data"]["msg"].stringValue)
                    }
                }
                else
                {
                    ShowMessage("消费记录作废失败!")
                }
                
            })
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
}
