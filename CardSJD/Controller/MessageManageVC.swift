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
        table.cellHeight = 65
        
        table.refreshWord = NoticeWord.MsgChange.rawValue
        
        let url = APPURL+"Public/Found/?service=Shopa.getMessagesList&shopid="+SID+"&page=[page]&perNumber=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: MessageModel.self, CellIdentifier: "MessageListCell")
        
        table.show()
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
