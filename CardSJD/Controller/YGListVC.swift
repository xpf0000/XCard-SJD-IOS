//
//  YGListVC.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class YGListVC: UIViewController,UITableViewDelegate {

    let table = XTableView()
    
    func refresh()
    {
        table.httpHandle.reSet()
        table.httpHandle.handle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refresh), name: NoticeWord.ADDYGSuccess.rawValue, object: nil)

        self.view.backgroundColor = APPBGColor
        table.backgroundColor = APPBGColor
        self.view.addSubview(table)
        
        table.frame = CGRectMake(0, 0, swidth, sheight-64-40)
        table.backgroundColor = APPBGColor
        table.cellHeight = 90
        
        table.Delegate(self)
        
        let url = APPURL+"Public/Found/?service=Power.getShopWorker&id="+SID
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: YuangongModel.self, CellIdentifier: "YGListCell")
        
        table.show()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("YGListVC viewDidAppear !!!!!!")
        
        for i in 0...20
        {
            let index=NSIndexPath(forRow: i, inSection: 0)
            
            if let cell = table.cellForRowAtIndexPath(index)
            {
                cell.deSelect()
                if cell.selected
                {
                    print(index)
                }
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alert = XCommonAlert(title: "删除员工", message: nil, buttons: "确定","取消")
        
        alert.show()
        
        alert.click({[weak self] (index) -> Bool in
            
            if index == 0
            {
                self?.doDel(indexPath.row)
            }

            return true
            })
        
    }
    
    func doDel(index:Int)
    {
        XWaitingView.show()
        
        let m = table.httpHandle.listArr[index] as! YuangongModel
        let url=APPURL+"Public/Found/?service=Power.delShopWorker"
        let body="id="+m.id
        
        XHttpPool.requestJson( url, body: body, method: .POST) {[weak self](o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                self?.table.httpHandle.listArr.removeAtIndex(index)
                self?.table.deleteRowsAtIndexPaths([NSIndexPath.init(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "员工删除失败" : msg
                
                XAlertView.show(msg!, block: nil)
            }
            
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("YGListVC viewDidDisappear !!!!!!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

}
