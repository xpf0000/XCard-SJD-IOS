//
//  CardTopupVC.swift
//  TJQS
//
//  Created by X on 16/9/9.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CardTopupVC: UIViewController,UITextFieldDelegate,UITableViewDelegate {
    
    @IBOutlet var noView: UIView!
    
    @IBOutlet var noMsg: UILabel!
    
    @IBOutlet var hasView: UIView!
    
    @IBOutlet var edit: UITextField!
    
    @IBOutlet var btn: UIButton!
    
    @IBOutlet var table: XTableView!
    
    @IBOutlet var tel: UILabel!
    
    @IBOutlet var name: UILabel!
    
    var typeModel:CardTypeModel?
    {
        didSet
        {
            btn.enabled = typeModel != nil
        }
    }
    
    var model:MemberModel?
        {
        didSet
        {
            if model == nil || model?.uid == ""
            {
                tel.text = ""
                name.text = ""
                btn.enabled = false
                noMsg.text = "该手机号码暂时不是会员, 请先注册为怀府网会员"
                noView.hidden = false
                
            }
            else
            {

                tel.text = model?.mobile
                name.text = model?.truename
                noView.hidden = true
                
                let url = APPURL+"Public/Found/?service=Hyk.getShopCardY&shopid="+SID+"&uid="+model!.uid
                
                table.httpHandle.url = url
                table.httpHandle.reSet()
                table.httpHandle.handle()
                
            }
            
        }
    }
    
    override func pop() {
        edit.removeTextChangeBlock()
        super.pop()
    }
    
    func toNext()
    {
        
        
        if self.title == "充值"
        {
            let vc = "CardTopupDoVC".VC("Main") as! CardTopupDoVC
            vc.userModel = model
            vc.typeModel = typeModel
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let vc = "CardConsumeDoVC".VC("Main") as! CardConsumeDoVC
            vc.userModel = model
            vc.typeModel = typeModel
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    func reshow()
    {
        let txt = edit.text!
        
        if txt.length() == 11
        {
            
            let url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopd.getUserInfoM&mobile="+txt+"&shopid="+SID
            
            XHttpPool.requestJson(url, body: nil, method: .POST) { [weak self](o) -> Void in
                
                if let info = o?["data"]["info"][0]
                {
                    self?.model = MemberModel.parse(json: info, replace: nil)
                }
                
            }
            
            
        }
        else
        {
            table.httpHandle.listArr.removeAll(keepCapacity: false)
            table.reloadData()
            tel.text = "请输入手机号"
            name.text = ""
            btn.enabled = false
            noView.hidden = true
        }


    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        edit.addEndButton()
        edit.delegate = self
        
        noView.hidden = true
        
        let leftView = UIView()
        leftView.frame = CGRectMake(0, 0, 42, 42)
        let left = UIImageView()
        left.frame = CGRectMake(8, 6, 30, 30)
        left.image = "search.png".image
        leftView.addSubview(left)
        
        edit.leftView = leftView
        edit.leftViewMode = .Always
        
        edit.onTextChange {[weak self] (txt) in
            
            print("txt: "+txt)
            self?.reshow()
            
        }
        
        btn.enabled = false
        
        btn.setBackgroundImage(APPBtnGrayColor.image, forState: .Disabled)
        
        btn.setBackgroundImage(APPOrangeColor.image, forState: .Normal)
        
        btn.click {[weak self] (btn) in
            
            self?.toNext()
        }
        
        table.cellHeight = 80.0

        table.Delegate(self)
        table.refreshWord = NoticeWord.CardTopupSuccess.rawValue
        table.refreshWord = NoticeWord.CardConsumSuccess.rawValue
        
        table.httpHandle.BeforeBlock { [weak self](arr) in
            if self == nil {return}
            
            if self?.title == "充值"
            {
                self?.table.httpHandle.listArr = arr.filter({ (item) -> Bool in
                    
                    return (item as! CardTypeModel).type == "充值卡" || (item as! CardTypeModel).type == "计次卡"
                })
            }

            for (i,item) in self!.table.httpHandle.listArr.enumerate()
            {
                if let m = item as? CardTypeModel
                {
                    m.enable = true
                    m.selected = i == 0
                    
                    if i == 0
                    {
                        self?.typeModel = m
                    }
                    
                }
            }
            
            
        }
        
        table.setHandle("", pageStr: "[page]", keys: ["data","info"], model: CardTypeModel.self, CellIdentifier: "CardTypeCell")
        
    }

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return range.location < 11
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEdit()
        
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        for (row,item) in table.httpHandle.listArr.enumerate()
        {
            if row == indexPath.row
            {
                (item as! CardTypeModel).selected = true
                self.typeModel = (item as! CardTypeModel)
            }
            else
            {
                (item as! CardTypeModel).selected = false
            }
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit
    {
        print("CardTopupVC deinit !!!!!!!!!!!!")
    }
    
}
