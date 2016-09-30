//
//  ChooseTypeVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ChooseTypeVC: UIViewController,UITableViewDelegate {
    
    var user:MemberModel = MemberModel()
    {
        didSet
        {
            let url1 = APPURL+"Public/Found/?service=Hyk.getShopCardY&shopid="+SID+"&uid="+user.uid
            
            httpHandle.setHandle(nil, url: url1, pageStr: "[page]", keys: ["data","info"], model: CardTypeModel.self)
            
            httpHandle.BeforeBlock {[weak self] (arr) in
                
                self?.refresh()
            }
            
            httpHandle.handle()
        }
    }
    
    let table = XTableView()
    
    let httpHandle = XHttpHandle()
    
    func refresh()
    {
        if httpHandle.listArr.count == 0{return}
        if table.httpHandle.listArr.count == 0{return}
        
        for item in table.httpHandle.listArr
        {
            let model = item as! CardTypeModel
            var hidden = false
            for m in httpHandle.listArr
            {
                if (m as! CardTypeModel).cardid == model.id
                {
                    hidden = true
                    break
                }
            }
            
            if hidden
            {
                model.iconHidden = true
                model.info = "已领取"
            }
            
        }
        
        table.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.addBackButton()
        self.title = "卡选择"
        
        self.view.backgroundColor = APPBGColor
        self.view.addSubview(table)
        table.frame = CGRectMake(0, 12, swidth, sheight-64-12)
        table.backgroundColor = APPBGColor
        
        table.cellHeight = 80.0
        
        table.httpHandle.BeforeBlock {[weak self] (arr) in
            
            self?.refresh()
        }
      
        let url = APPURL+"Public/Found/?service=Hyk.getShopCard&shopid="+SID+"&uid="+UID
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: CardTypeModel.self, CellIdentifier: "CardTypeCell")
        
        table.show()
        
        table.Delegate(self)
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let m = table.httpHandle.listArr[indexPath.row] as? CardTypeModel
        {
            if !m.iconHidden
            {
                let alert = XCommonAlert(title: "确定要开通会员卡?", message: nil, buttons: "取消","确定")
                
                alert.click({ [weak self](i) -> Bool in
                    
                    if i == 1
                    {
                        self?.doOpen(m.id)
                    }
                    
                    return true
                })
                
                alert.show()
            }
        }
        
        
    }
    
    func doOpen(id:String)
    {
        XWaitingView.show()
        
        let url=APPURL+"Public/Found/?service=Hyk.addCard&uid="+user.uid+"&username="+user.username+"&cardid="+id
        
        XHttpPool.requestJson( url, body: nil, method: .POST) { [weak self](o) -> Void in
            
            XWaitingView.hide()
            if(o?["data"]["code"].int == 0)
            {
                
                self?.success()
                XAlertView.show("领取会员卡成功", block: nil)
   
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "领取会员卡失败" : msg
                XAlertView.show(msg!, block: nil)
            }
            
        }
    }
    
    func success()
    {
        httpHandle.listArr.removeAll()
        httpHandle.reSet()
        httpHandle.handle()
        
        table.httpHandle.reSet()
        table.httpHandle.handle()
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
