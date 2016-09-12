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
    
    
    @IBAction func doClick(sender: UIButton) {
        
        
    }
    
    let nameArr = ["新用户开卡","充值","消费","管理卡类","岗位设置","消息","活动","会员管理","会员密码重置","店铺设置","员工管理"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.cellHeight = 70
        
        //        let url = "http://api.0539cn.com/index.php?c=Order&a=orderList&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20&status=3"
        //
        //        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: OrderModel.self, CellIdentifier: "MyOrderCancelCell")
        //
        //        table.show()
        
        
        table.setHandle("", pageStr: "", keys: ["data"], model: PowerModel.self, CellIdentifier: "PowerListCell")
        
        for name in nameArr
        {
            let m = PowerModel()
            m.name = name
            table.httpHandle.listArr.append(m)
        }
        
        table.reloadData()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
