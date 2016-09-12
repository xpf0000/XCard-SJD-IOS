//
//  UserMessageVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class UserMessageVC: UIViewController {

    let table = XTableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.addBackButton()
        self.title = "消息"
        table.frame = CGRectMake(0, 12, swidth, sheight-64-12)
        table.backgroundColor = APPBGColor
        table.cellHeight = 90
        
//        let url = "http://api.0539cn.com/index.php?c=Order&a=orderList&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20&status=3"
//        
//        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: OrderModel.self, CellIdentifier: "MyOrderCancelCell")
//        
//        table.show()
        
        
        table.setHandle("", pageStr: "", keys: ["data"], model: MessageModel.self, CellIdentifier: "MessageCell")
        
        for _ in 0...20
        {
            let m = MessageModel()
            table.httpHandle.listArr.append(m)
        }
        
        table.reloadData()

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
