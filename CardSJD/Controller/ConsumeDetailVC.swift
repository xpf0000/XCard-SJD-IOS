//
//  ConsumeDetailVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ConsumeDetailVC: UIViewController {
    
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
        
        total.text = "￥"+model.all
        
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
        
        let url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopt.getCostList&shopid="+SID+"&stime="+stimeStr+"&etime="+etimeStr+"&page=[page]&perNumber=20&ctypeid="+ctypeid
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: MoneyDetailModel.self, CellIdentifier: "TopupDetailCell")
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
}
