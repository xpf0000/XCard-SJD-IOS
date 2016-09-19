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
    
    @IBOutlet var table: XTableView!
    
    var isEdit = false
    
    override func pop() {
        edit.removeTextChangeBlock()
        super.pop()
    }
    
    func toEdit()
    {
        isEdit = !isEdit
        for item in table.httpHandle.listArr
        {
            (item as! MemberModel).enable = isEdit
            (item as! MemberModel).selected = false
        }
        
        table.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "会员管理"
        self.addBackButton()
        self.addNvButton(false, img: "add.png", title: nil) {[weak self] (btn) in
            self?.toEdit()
        }
        
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
        
        edit.setTextChangeBlock {[weak self] (txt) in
            
            print("txt: "+txt)
            
        }

        table.setHandle("", pageStr: "", keys: ["data"], model: MemberModel.self, CellIdentifier: "MemberListCell")
        table.cellHeight = 90.0
        
        for _ in 0...19
        {
            let m = MemberModel()
            table.httpHandle.listArr.append(m)
        }
        table.Delegate(self)
        
        table.reloadData()
        
        
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
            let vc = "MemberInfoVC".VC("Main")
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
