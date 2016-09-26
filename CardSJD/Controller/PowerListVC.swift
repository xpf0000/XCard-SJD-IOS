//
//  PowerListVC.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class PowerListVC: UIViewController {

    @IBOutlet var ptitle: UILabel!
    
    @IBOutlet var table: XTableView!
    
    @IBOutlet var btn: UIButton!
    
    var gw:GangweiModel = GangweiModel()
    {
        didSet
        {
            pwArr = gw.power.split(",")
        }
    }
    var pwArr:[String] = []
    
    @IBAction func doClick(sender: UIButton) {
        
        XWaitingView.show()
        sender.enabled = false
        
        var power = ""
        
        for item in table.httpHandle.listArr
        {
            if let m = item as? PowerModel
            {
                if m.checked
                {
                    if power == ""
                    {
                        power += m.id
                    }
                    else
                    {
                        power += ","+m.id
                    }
                    
                }
            }
        }
        
        let url=APPURL+"Public/Found/?service=Power.updateJobPower"
        let body="shopid="+SID+"&jobid="+gw.id+"&power="+power
        
        XHttpPool.requestJson( url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                NoticeWord.UpDatePowerSuccess.rawValue.postNotice()
                XAlertView.show("权限修改成功", block: { [weak self]() in
                    
                })

                return
                
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "权限修改失败" : msg
                sender.enabled = true
                
                XAlertView.show(msg!, block: nil)
                
            }
            
        }
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackButton()
        
        ptitle.text = "当前岗位: "+gw.name
        table.cellHeight = 70
        
        let url = APPURL+"Public/Found/?service=Setting.getShopPower"
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: PowerModel.self, CellIdentifier: "PowerListCell")
        
        table.httpHandle.BeforeBlock { [weak self](arr) in
            if self == nil {return}
            for item in arr
            {
                if let m = item as? PowerModel
                {
                    m.checked = self!.pwArr.contains(m.id)
                }
            }
        }
        
        table.show()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
