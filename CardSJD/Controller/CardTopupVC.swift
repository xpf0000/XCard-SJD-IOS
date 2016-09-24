//
//  CardTopupVC.swift
//  TJQS
//
//  Created by X on 16/9/9.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CardTopupVC: UIViewController,UITextFieldDelegate,UITableViewDelegate {
    
    @IBOutlet var edit: UITextField!
    
    @IBOutlet var btn: UIButton!
    
    @IBOutlet var table: XTableView!
    
    @IBOutlet var tel: UILabel!
    
    @IBOutlet var name: UILabel!
    
    
    override func pop() {
        edit.removeTextChangeBlock()
        super.pop()
    }
    
    func toNext()
    {
        let vc = "CardTopupDoVC".VC("Main")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        edit.addEndButton()
        edit.delegate = self
        
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
            m.enable = true
            table.httpHandle.listArr.append(m)
        }
        table.Delegate(self)
        
        table.reloadData()
        
        
    }
    
    func reshow()
    {
        let txt = edit.text!
        
        if txt.length() == 11
        {
            btn.enabled = true
        }
        else
        {
            btn.enabled = false
        }
        
        
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
            }
            else
            {
                (item as! CardTypeModel).selected = false
            }
        }
        
        table.reloadData()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit
    {
        print("OpenCardVC deinit !!!!!!!!!!!!")
    }
    
}
