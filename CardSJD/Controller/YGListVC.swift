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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = APPBGColor
        table.backgroundColor = APPBGColor
        self.view.addSubview(table)
        
        table.frame = CGRectMake(0, 0, swidth, sheight-64-40)
        table.backgroundColor = APPBGColor
        table.cellHeight = 200
        
        //        let url = "http://api.0539cn.com/index.php?c=Order&a=orderList&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20&status=3"
        //
        //        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: OrderModel.self, CellIdentifier: "MyOrderCancelCell")
        //
        //        table.show()
        
        table.Delegate(self)
        table.setHandle("", pageStr: "", keys: ["data"], model: YuangongModel.self, CellIdentifier: "YGListCell")
        
        for _ in 0...20
        {
            let m = YuangongModel()
            table.httpHandle.listArr.append(m)
        }
        
        table.reloadData()
        
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
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("YGListVC viewDidDisappear !!!!!!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
