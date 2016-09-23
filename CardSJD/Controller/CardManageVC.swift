//
//  CardManageVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CardManageVC: UIViewController,UITableViewDelegate {
    
    let table = XTableView()
    
    func addNew()
    {
        let vc = "AddCardVC".VC("Main")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.addBackButton()
        self.title = "卡管理"
        
        self.addNvButton(false, img: "add.png", title: nil) {[weak self] (btn) in
            
            self?.addNew()
        }
        
        self.view.backgroundColor = APPBGColor
        self.view.addSubview(table)
        table.frame = CGRectMake(0, 12, swidth, sheight-64-12)
        table.backgroundColor = APPBGColor
        
        //        let url = "http://api.0539cn.com/index.php?c=Order&a=orderList&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20&status=3"
        //
        //        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: OrderModel.self, CellIdentifier: "MyOrderCancelCell")
        //
        //        table.show()
        
        
        let names = ["充值卡","积分卡","计次卡","打折卡"]
        
        table.setHandle("", pageStr: "", keys: ["data"], model: CardTypeModel.self, CellIdentifier: "CardTypeCell")
        table.hideFootRefresh()
        table.hideHeadRefresh()
        table.cellHeight = 80.0
        for(index,name) in names.enumerate()
        {
            let m = CardTypeModel()
            m.name = name
            m.img = "card_type\(index).png"
            m.info = "卡说明"
            table.httpHandle.listArr.append(m)
        }
        table.Delegate(self)
        
        table.reloadData()
        
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alert = XCommonAlert(title: nil, message: nil, buttons: "删除","编辑","取消")
        
        alert.click {[weak self] (index) -> Bool in
            
            return true
        }
        
        alert.show()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
