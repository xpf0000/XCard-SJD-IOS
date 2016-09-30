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
        self.view.backgroundColor = APPBGColor
        self.view.addSubview(table)
        table.frame = CGRectMake(0, 12, swidth, sheight-64-12)
        table.backgroundColor = APPBGColor
        table.cellHeight = 90
        
        let url = APPURL+"Public/Found/?service=Shopd.getGonggao&page=[page]&perNumber=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: MessageModel.self, CellIdentifier: "MessageCell")
        table.httpHandle.replace = ["descript":"description"]
        table.show()
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
