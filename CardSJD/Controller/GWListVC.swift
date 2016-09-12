//
//  GWListVC.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class GWListVC: UIViewController {

    let table = XTableView()
    
    let nameArr = ["经理","出纳","会计","客服","文案"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = APPBGColor
        table.backgroundColor = APPBGColor
        self.view.addSubview(table)
        
        table.frame = CGRectMake(0, 0, swidth, sheight-64-40)
        table.backgroundColor = APPBGColor
        table.cellHeight = 70
        
        //        let url = "http://api.0539cn.com/index.php?c=Order&a=orderList&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20&status=3"
        //
        //        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: OrderModel.self, CellIdentifier: "MyOrderCancelCell")
        //
        //        table.show()
        
        
        table.setHandle("", pageStr: "", keys: ["data"], model: GangweiModel.self, CellIdentifier: "GWListCell")
        
        for name in nameArr
        {
            let m = GangweiModel()
            m.name = name
            table.httpHandle.listArr.append(m)
        }
        
        table.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
