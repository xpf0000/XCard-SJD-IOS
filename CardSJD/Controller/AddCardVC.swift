//
//  AddCardVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ColorModel: Reflect {
    
    var color = ""
    var selected = false
    
}

class AddCardVC: UITableViewController,UICollectionViewDelegate {

    @IBOutlet var typeCell: UIView!
    
    @IBOutlet var typeButton: UIButton!
    
    @IBOutlet var colorList: XCollectionView!
    
    @IBOutlet var info: XTextView!
    
    weak var typeBtn:UIButton?
    
    var model:CardTypeModel = CardTypeModel()
    
    var selectColor = ""
    
    var typeid = 1
    
    @IBAction func submit(sender: UIButton) {
        
        
        XWaitingView.show()
        sender.enabled = false
        
        var url = ""
        var body = ""
        var msg = ""
        if model.id != ""
        {
            url=APPURL+"Public/Found/?service=Shopd.updateShopCard"
            body="id="+model.id+"&color="+selectColor.replace("#", with: "")+"&info="+info.text!.trim()
            msg = "会员卡修改"
        }
        else
        {
            
            
            url=APPURL+"Public/Found/?service=Shopd.addShopCard"
            body="shopid="+SID+"&color="+selectColor.replace("#", with: "")+"&info="+info.text!.trim()+"&typeid=\(typeid)"
            msg = "会员卡添加"
        }
        
        XHttpPool.requestJson( url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                
                NoticeWord.ShopsCardUpdateSuccess.rawValue.postNotice()
                XAlertView.show(msg+"成功", block: { [weak self]() in
                    
                    self?.pop()
                    
                })
                
            }
            else
            {
                var m = o?["data"]["msg"].stringValue
                m = m == "" ? msg+"失败" : m
                sender.enabled = true

                XAlertView.show(m!, block: nil)
                
            }
            
        }
        
        
    }
    
    @IBAction func doChooseType(sender: UIButton) {
        
        if model.id != "" {return}
        
        if sender.selected {return}
        sender.selected = true
        typeBtn?.selected = false
        typeBtn = sender
        
        typeid = sender.tag - 20
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        if model.id != ""
        {
            self.title = "编辑卡片"
        }
        else
        {
            self.title = "添加卡片"
        }
        
       
        typeBtn = typeButton
        info.placeHolder("请输入卡片说明!")
        
        if model.id != ""
        {
            for item in typeCell.subviews
            {
                if let b = item as? UIButton
                {
                    b.selected = b.titleLabel?.text == model.type
                }
            }
        }
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        colorList.Delegate(self)
        
        colorList.ViewLayout.scrollDirection = .Horizontal
        colorList.ViewLayout.itemSize = CGSizeMake(60.0, 60.0)
        colorList.ViewLayout.minimumLineSpacing = 5.0
        
        colorList.setHandle("", pageStr: "", keys: [], model: ColorModel.self, CellIdentifier: "AddCardColorCell")
        
        for (i,item) in XCardColor.enumerate()
        {
            let m = ColorModel()
            m.color = item
            
            if model.id != ""
            {
                m.selected = item == model.color
                if m.selected
                {
                    selectColor = item
                }
                
            }
            else
            {
                if i == 0 {
                    m.selected = true
                    selectColor = item
                }
            }

            colorList.httpHandle.listArr.append(m)
        }
        
        colorList.reloadData()
        
        tableView.reloadData()
        
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 0 || indexPath.row == 3)
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else if(indexPath.row > 3)
        {
            cell.separatorInset=UIEdgeInsetsMake(0, SW, 0, 0)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, SW, 0, 0)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, 15, 0, 15)
                } else {
                    // Fallback on earlier versions
                }
            }
            
        }
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        tableView.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                tableView.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let m = colorList.httpHandle.listArr[indexPath.row] as! ColorModel
        if m.selected {return}
        
        for item in colorList.httpHandle.listArr
        {
            
            (item as! ColorModel).selected = false
        }
        
        selectColor = m.color
        
        m.selected = true
        
        collectionView.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
