//
//  ShopSetupTableVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ShopSetupTableVC: UITableViewController {

    @IBOutlet var icon: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var describe: UILabel!
    
    @IBOutlet var address: UITextField!
    
    @IBOutlet var tel: UITextField!
    
    func submit(sender:UIButton)
    {
        if !address.checkNull() || !tel.checkNull()
        {
            return
        }
        
        sender.enabled=false
        XWaitingView.show()
        
        let url=APPURL+"Public/Found/?service=Shopd.updateShopInfo"
        let body="id="+SID+"&address="+address.text!.trim()+"&tel="+tel.text!.trim()
        
        XHttpPool.requestJson( url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                XAlertView.show("信息修改成功", block: { [weak self]() in
                    if self == nil {return}
                })
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "信息修改失败" : msg
         
                XAlertView.show(msg!, block: nil)
            }
            
            sender.enabled = true
            
        }
        
        
    }
    
    func http()
    {
        let url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopd.getShopInfo&id="+SID
        
        XHttpPool.requestJson(url, body: nil, method: .POST) { [weak self](o) -> Void in
            
            if(o?["data"].dictionaryValue.count > 0)
            {
                if(o!["data"]["code"].intValue == 0 && o?["data"]["info"].arrayValue.count > 0)
                {
                    
                    let model = UserModel.parse(json: o!["data"]["info"][0], replace: nil)
                    
                    DataCache.Share.User.logo = model.logo
                    DataCache.Share.User.shopname = model.shopname
                    DataCache.Share.User.tel = model.tel
                    DataCache.Share.User.address = model.address
                    DataCache.Share.User.info = model.info
                    
                    self?.show()
                    
                }
                
            }
        }
        
    }
    
    func show()
    {
        icon.url = DataCache.Share.User.logo
        name.text = DataCache.Share.User.shopname
        describe.text = DataCache.Share.User.shopcategory
        address.text = DataCache.Share.User.address
        tel.text = DataCache.Share.User.tel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.http()
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        icon.layer.masksToBounds = true
        icon.layer.borderColor = "dcdcdc".color?.CGColor
        icon.layer.borderWidth = 2.0
        
        address.autoReturn(tel)
 
    }

    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if #available(iOS 8.0, *) {
            cell.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if #available(iOS 8.0, *) {
            tableView.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            // Fallback on earlier versions
        }
        icon.layer.cornerRadius = icon.frame.size.width/2.0
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }

    deinit
    {
        address.autoReturnClose()
        print("ShopSetupTableVC deinit !!!!!!!!!!")
    }
}
