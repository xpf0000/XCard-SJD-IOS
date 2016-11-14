//
//  MessageManageVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MessageManageVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let table = XTableView()
    
    func addNew()
    {
        let vc = "CreateMessageVC".VC("Main")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.addBackButton()
        self.title = "消息管理"
        
        self.addNvButton(false, img: "add.png", title: nil) {[weak self] (btn) in
            
            self?.addNew()
        }
        
        self.view.backgroundColor = APPBGColor
        self.view.addSubview(table)
        table.frame = CGRectMake(0, 0, swidth, sheight-64)
        table.backgroundColor = APPBGColor
        table.cellHeight = 65
        table.Delegate(self)
        table.DataSource(self)
        table.refreshWord = NoticeWord.MsgChange.rawValue
        
        let url = APPURL+"Public/Found/?service=Shopa.getMessagesList&shopid="+SID+"&page=[page]&perNumber=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: MessageModel.self, CellIdentifier: "MessageListCell")
        
        table.show()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return  true
        
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        return "删除"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            
            let id=(self.table.httpHandle.listArr[indexPath.row] as! MessageModel).id
            
            let url=APPURL+"Public/Found/?service=Shopa.delMessages&id="+id
            
            XHttpPool.requestJson(url, body: nil, method: .GET, block: { (json) in
                
                if let status = json?["data"]["code"].int
                {
                    if status == 0
                    {
                        self.table.httpHandle.listArr.removeAtIndex(indexPath.row)
                        self.table.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                        
                    }
                    else
                    {
                        ShowMessage(json!["data"]["msg"].stringValue)
                    }
                }
                else
                {
                    ShowMessage("删除消息失败!")
                }
                
            })
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
