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
        
        let alert = XCommonAlert(title: nil, message: nil, buttons: "作废","编辑","取消")
        
        alert.click {[weak self] (index) -> Bool in
            if self == nil {return false}
            
            if index == 0
            {
                self?.delCard(indexPath.row)
            }
            
            if index == 1
            {
                let vc = "AddCardVC".VC("Main") as! AddCardVC
                vc.model = self!.table.httpHandle.listArr[indexPath.row] as! CardTypeModel
                self?.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            return true
        }
        
        alert.show()
        
    }
    
    func delCard(row:Int)
    {
        let alert = XCommonAlert(title: "提醒", message: "确定要作废该会员卡?", buttons: "取消","确定")
        
        alert.click {[weak self] (index) -> Bool in
            if self == nil {return false}

            if index == 1
            {
                self?.doDel(row)
            }
            
            return true
        }
        
        alert.show()
    }
    
    func doDel(row:Int)
    {
        XWaitingView.show()
        
        let m = table.httpHandle.listArr[row] as! CardTypeModel
        
        let url=APPURL+"Public/Found/?service=Shopd.delShopCard"
        let body="id="+m.id
        
        XHttpPool.requestJson( url, body: body, method: .POST) { [weak self](o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                self?.table.noticedRefresh()
                XAlertView.show("会员卡作废成功", block: nil)
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "会员卡作废失败" : msg

                XAlertView.show(msg!, block: nil)
                
            }
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
