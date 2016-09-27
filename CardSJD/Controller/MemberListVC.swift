//
//  MemberListVC.swift
//  TJQS
//
//  Created by X on 16/9/9.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MemberListVC: UIViewController,UITextFieldDelegate,UITableViewDelegate {
    
    @IBOutlet var edit: UITextField!
    
    @IBOutlet var all: UILabel!
    
    @IBOutlet var table: XTableView!
    
    var isEdit = false
    
    override func pop() {
        edit.removeTextChangeBlock()
        super.pop()
    }
    
//    func toEdit()
//    {
//        isEdit = !isEdit
//        for item in table.httpHandle.listArr
//        {
//            (item as! MemberModel).enable = isEdit
//            (item as! MemberModel).selected = false
//        }
//        
//        table.reloadData()
//        
//    }
    
    func toSearch(str:String)
    {
        if str.length() == 11
        {
            table.httpHandle.url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopd.getUserInfoM&mobile="+str+"&shopid="+SID
            table.httpHandle.reSet()
            table.httpHandle.handle()
        }
        else if str.length() == 0
        {
            
            let url = APPURL+"Public/Found/?service=Shopd.getShopUser&id="+SID+"&page=[page]&perNumber=20"
            table.httpHandle.url = url
            table.httpHandle.reSet()
            table.httpHandle.handle()
        }
        else
        {
            all.text = "全部共0位会员"
            table.httpHandle.url = ""
            table.httpHandle.reSet()
            table.httpHandle.listArr.removeAll(keepCapacity: false)
            table.reloadData()
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "会员管理"
        self.addBackButton()
        
//        self.addNvButton(false, img: "add.png", title: nil) {[weak self] (btn) in
//            self?.toEdit()
//        }
        
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
            
           self?.toSearch(txt)
            
        }
        
        table.cellHeight = 90.0
        table.Delegate(self)
        
        table.httpHandle.BeforeBlock { [weak self](arr) in
            
            self?.all.text = "全部共\(arr.count)位会员"
            
        }
        
        let url = APPURL+"Public/Found/?service=Shopd.getShopUser&id="+SID+"&page=[page]&perNumber=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: MemberModel.self, CellIdentifier: "MemberListCell")
        
        table.show()

        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEdit()
        
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if isEdit
        {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? MemberListCell
            {
                cell.model.selected = !cell.model.selected
                cell.btn.selected = cell.model.selected
            }
        }
        else
        {
            let vc = "MemberInfoVC".VC("Main") as! MemberInfoVC
            vc.model = table.httpHandle.listArr[indexPath.row] as! MemberModel
            self.navigationController?.pushViewController(vc, animated: true)
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
        print("OpenCardVC deinit !!!!!!!!!!!!")
    }
    
}
