//
//  ShopSetupTableVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ShopSetupTableVC: UITableViewController {

    @IBOutlet var banner: UIImageView!
    
    @IBOutlet var icon: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var describe: UILabel!
    
    @IBOutlet var address: UITextField!
    
    @IBOutlet var tel: UITextField!
    
    var bImage:UIImage?
    {
        didSet
        {
            if(bImage != nil)
            {
                banner.image = bImage
            }
        }
    }
    
    var hImage:UIImage?
        {
        didSet
        {
            if(hImage != nil)
            {
                icon.image = hImage
            }
            
        }
    }
    
    var harr:[CGFloat] = [12,100,140,50,50]
    
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
        
        
        if(hImage != nil)
        {
            let dict=[
                "id":SID
            ]
            
            let imgDataArr:[NSData] = [hImage!.data(0.5)!]
            let url=APPURL+"Public/Found/?service=Shopd.updateShopLogo"
            
            hImage = nil
            
            XHttpPool.upLoad(url, parameters: dict, file: imgDataArr, name: "file", progress: nil) { [weak self](o) -> Void in
                
                if o == nil || o?["ret"].int != 200
                {
                    ShowMessage("头像上传失败")
                }
                
            }
            
        }
        
        if(bImage != nil)
        {
            let dict=[
                "id":SID
            ]
            
            bImage = nil
            
            let imgDataArr:[NSData] = [bImage!.data(0.5)!]
            let url=APPURL+"Public/Found/?service=Shopd.updateShopBanner"
            
            XHttpPool.upLoad(url, parameters: dict, file: imgDataArr, name: "file", progress: nil) { [weak self](o) -> Void in
                
                if o == nil || o?["ret"].int != 200
                {
                    ShowMessage("广告图上传失败")
                }
                
            }
            
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
                    DataCache.Share.User.banner = model.banner
                    
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
        banner.url = DataCache.Share.User.banner
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.http()
        
        harr[2] = swidth * 313.0 / 750.0 + 48
        tableView.reloadData()
        
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return harr[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 1
        {
            let picker = XPhotoPicker()
            picker.useSystem = true
            picker.getPhoto(self) { [weak self](res) in
                
                if let img = res[0].image
                {
                    let v = XPhotoCrap()
                    v.show(img, wh: 1.0, b: {[weak self] (image) in
                        
                        self?.hImage = image
                        
                        })
                }
                
            }
        }
        
        if indexPath.row == 2
        {
            let picker = XPhotoPicker()
            picker.useSystem = true
            picker.getPhoto(self) { [weak self](res) in
                
                if let img = res[0].image
                {
                    let v = XPhotoCrap()
                    v.show(img, wh: 750.0/313.0, b: {[weak self] (image) in
                        
                        self?.bImage = image
                        
                        })
                }
                
            }
        }
        
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
