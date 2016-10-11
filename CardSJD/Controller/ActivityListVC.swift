//
//  ActivityListVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ActivityListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let table = XTableView()
    
    func toCreatActivity()
    {
        let vc = "CreatActivityVC".VC("Main")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "活动管理"
        self.addBackButton()
        self.view.backgroundColor = APPBGColor
        
        self.addNvButton(false, img: "add.png", title: nil) {[weak self] (btn) in
            self?.toCreatActivity()
        }

        table.frame = CGRectMake(0, 0, SW, SH-64)
        self.view.addSubview(table)
        
        table.separatorStyle = .None
        table.refreshWord = NoticeWord.ADDActivitySuccess.rawValue
        
        table.Delegate(self)
        table.DataSource(self)
        
        let url = APPURL+"Public/Found/?service=Shopa.getShopHD&id="+SID+"&page=[page]&perNumber=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: ActivityModel.self, CellIdentifier: "ActivityListCell")
        table.cellHeight = SW * 10.0 / 16.0
        
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
        
        return "作废"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            
            let id=(self.table.httpHandle.listArr[indexPath.row] as! ActivityModel).id
            
            let url=APPURL+"Public/Found/?service=Shopa.delShopHD&id="+id
            
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
                    ShowMessage("活动作废失败!")
                }
                
            })
            
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
