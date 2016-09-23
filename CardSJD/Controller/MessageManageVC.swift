//
//  MessageManageVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MessageManageVC: UIViewController {
    
    let table = XTableView()
    
    func addNew()
    {
        let vc = "CreateMessageVC".VC("Main")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.addBackButton()
        self.title = "消息管理"
        
        self.addNvButton(false, img: "add.png", title: nil) {[weak self] (btn) in
            
            self?.addNew()
        }
        
        self.view.backgroundColor = APPBGColor
        self.view.addSubview(table)
        table.frame = CGRectMake(0, 0, swidth, sheight-64)
        table.backgroundColor = APPBGColor
        table.cellHeight = 90
        
        //        let url = "http://api.0539cn.com/index.php?c=Order&a=orderList&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20&status=3"
        //
        //        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: OrderModel.self, CellIdentifier: "MyOrderCancelCell")
        //
        //        table.show()
        
        
        table.setHandle("", pageStr: "", keys: ["data"], model: MessageModel.self, CellIdentifier: "MessageListCell")
        
        for _ in 0...20
        {
            let m = MessageModel()
            m.title = "仅售228元,价值261元精致洗车"
            m.time = "2016-08-15 10:35"
            table.httpHandle.listArr.append(m)
        }
        
        table.reloadData()
        
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
