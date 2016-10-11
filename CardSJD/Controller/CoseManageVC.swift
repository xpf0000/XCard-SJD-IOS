//
//  CoseManageVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CoseManageVC: UIViewController,UITableViewDelegate {
    
    let table = XTableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.addBackButton()
        self.title = "消费管理"
   
        self.view.backgroundColor = APPBGColor
        self.view.addSubview(table)
        table.frame = CGRectMake(0, 12, swidth, sheight-64-12)
        table.backgroundColor = APPBGColor
        
        table.cellHeight = 80.0
        table.refreshWord = NoticeWord.ShopsCardUpdateSuccess.rawValue
        
        let url = APPURL+"Public/Found/?service=Hyk.getShopCard&shopid="+SID+"&uid="+UID
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: CardTypeModel.self, CellIdentifier: "CardTypeCell")
        
        table.show()
        
        table.Delegate(self)
        
        table.reloadData()
        
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc = "ConsumeManageVC".VC("Main") as! ConsumeManageVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
